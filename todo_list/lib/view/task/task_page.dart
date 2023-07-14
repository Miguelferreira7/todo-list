import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/controller/task_controller.dart';

class TaskPage extends GetView<TaskController> {
  TaskPage({Key? key}) : super(key: key);
  static const String route = "/task-page";

  final _taskController = Get.find<TaskController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [_buildBody(context), _buildSaveTaskButton(context)],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: const Text('Detalhes'),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 16),
          child: IconButton(
            onPressed: () => _taskController
                .deleteTask()
                .then((value) => Navigator.of(context).pop()),
            icon: const Icon(Icons.delete, color: Colors.red),
          ),
        )
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 8, top: 16),
            height: MediaQuery.of(context).size.height * .06,
            width: MediaQuery.of(context).size.width * .9,
            child: Container(
              width: MediaQuery.of(context).size.width * .7,
              margin: const EdgeInsets.only(left: 14, top: 4),
              padding: const EdgeInsets.only(bottom: 4),
              child: TextField(
                controller: _taskController.titleController,
                onChanged: (title) => _taskController.setTaskTitle(title),
                style: Theme.of(context)
                    .textTheme
                    .labelSmall
                    ?.copyWith(color: Colors.black),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Titulo...',
                  hintStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 4),
            height: MediaQuery.of(context).size.height * .08,
            width: MediaQuery.of(context).size.width * .8,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    'Horário',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
                GestureDetector(
                  onTap: () => _showDatePicker(context),
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.only(left: 4),
                    height: MediaQuery.of(context).size.height * .05,
                    width: MediaQuery.of(context).size.width * .25,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Obx(
                          () => Text(
                              _taskController.selectedTask.value
                                  .getDeadline(context),
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(color: Colors.black)),
                        ),
                        const Icon(Icons.arrow_drop_down_outlined,
                            color: Colors.black)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 4, bottom: 4),
            height: MediaQuery.of(context).size.height * .2,
            width: MediaQuery.of(context).size.width * .8,
            decoration: BoxDecoration(
              color: Colors.amber.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Container(
              margin: const EdgeInsets.only(left: 4, top: 8, right: 4),
              child: TextField(
                controller: _taskController.descriptionController,
                onChanged: (description) =>
                    _taskController.setTaskDescription(description),
                minLines: 1,
                maxLines: 10,
                decoration: const InputDecoration(
                  hintText: 'Descreva a atividade...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(bottom: 4, right: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    'Importante',
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(color: Colors.black),
                  ),
                ),
                Obx(
                  () => Switch(
                    value: _taskController.selectedTask.value.isImportant,
                    inactiveTrackColor: Colors.grey,
                    activeColor: Theme.of(context).colorScheme.primary,
                    onChanged: (bool value) {
                      _taskController.setTaskImportance(value);
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _showDatePicker(BuildContext context) async {
    await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) => _taskController.setTaskDeadline(
        value?.format(context) ?? _taskController.selectedTask.value.deadline));
  }

  Widget _buildSaveTaskButton(BuildContext context) {
    return Container(
      height: 40,
      width: MediaQuery.of(context).size.width * .8,
      margin: const EdgeInsets.only(top: 8, bottom: 16),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            Theme.of(context).colorScheme.primary,
          ),
        ),
        child: Text(
          "Salvar",
          style: Theme.of(context).textTheme.button,
        ),
        onPressed: () => _taskController
            .saveTask()
            .then((value) => Navigator.of(context).pop()),
      ),
    );
  }
}
