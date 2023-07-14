import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/controller/task_controller.dart';
import 'package:todo_list/model/task/task_model.dart';
import 'package:todo_list/view/authentication/sign_in_page.dart';
import 'package:todo_list/view/task/task_page.dart';

class TaskListPage extends StatefulWidget {
  TaskListPage({Key? key}) : super(key: key);
  static const String route = "/task-list-page";

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  final _taskController = Get.find<TaskController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
      floatingActionButton: _buildCreateTaskButton(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: false,
      title: Container(
        margin: const EdgeInsets.only(left: 8, top: 8),
        child: const Text(
          "To-do List",
          style: TextStyle(color: Colors.black),
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 16, top: 8),
          child: IconButton(
            onPressed: () async {
              await _taskController.doLogOff();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(SignInPage.route, (route) => false);
            },
            icon: Icon(Icons.logout_rounded, color: Theme.of(context).colorScheme.primary),
          ),
        )
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return GetX<TaskController>(builder: (tController) {
      if (tController.tasks.isNotEmpty) {
        return SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * .89,
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: tController.tasks.length,
              itemBuilder: (BuildContext context, int index) {
                TaskEntity taskIndex = tController.tasks[index];
                return _buildTaskCard(context, tController, taskIndex);
              },
            ),
          ),
        );
      } else {
        return Center(
          child: Container(
            margin: const EdgeInsets.only(left: 16, right: 16),
            child: const Text(
              "Você ainda não possui nenhuma tarefa, clique em '+' logo abaixo para criar uma nova tarefa.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
        );
      }
    });
  }

  FloatingActionButton _buildCreateTaskButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        await _taskController.clearSelectedTask();
        await Navigator.of(context)
            .pushNamed(TaskPage.route)
            .then((value) => _taskController.getAllTasks());
      },
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: const Icon(Icons.add, color: Colors.white, size: 28),
    );
  }

  Widget _buildTaskCard(
      BuildContext context, TaskController tController, TaskEntity task) {
    return GestureDetector(
      onTap: () async {
        tController.setTaskSelected(task);
        await Navigator.of(context).pushNamed(TaskPage.route);
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.amber.shade100,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF4E4A4A).withOpacity(.2),
              blurRadius: 4.0,
              spreadRadius: 2.0,
              offset: const Offset(2.0, 3.0),
            )
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      task.isImportant
                          ? Container(
                              padding: const EdgeInsets.only(right: 4),
                              child: Icon(
                                Icons.label_important_outlined,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            )
                          : const SizedBox.shrink(),
                      Text(
                        task.title,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.only(left: 4),
                  height: MediaQuery.of(context).size.height * .04,
                  width: MediaQuery.of(context).size.width * .2,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    task.getDeadline(context),
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(color: Colors.black),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(4),
              alignment: Alignment.centerLeft,
              child: Text(
                task.description,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelSmall,
              ),
            )
          ],
        ),
      ),
    );
  }
}
