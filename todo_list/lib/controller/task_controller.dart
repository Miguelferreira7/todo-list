import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/model/task_model.dart';
import 'package:uuid/uuid.dart';
import '../database/repository.dart';

class TaskController extends GetxController {
  @override
  void onInit() {
    getAllTasks();
    super.onInit();
  }

  final HiveDataBase _hiveDataBase = HiveDataBase();

  final tasks = <TaskModel>[].obs;
  final selectedTask = TaskModel(
    id: null,
    title: "",
    description: "",
    isImportant: false,
    deadline: null,
  ).obs;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  Future<void> getAllTasks() async {
    try {
      tasks.clear();
      tasks(await _hiveDataBase.getTasks());
    } catch (e) {
      return;
    }
  }

  Future<void> saveTask() async {
    try {
      tasks.clear();

      if (selectedTask.value.id == null) {
        const uuid = Uuid();
        selectedTask.value.id = uuid.v1();
        List<TaskModel> updatedTaskList =
            await _hiveDataBase.createTask(selectedTask.value);

        tasks(updatedTaskList);
        return;
      }

      List<TaskModel> updatedTaskList =
          await _hiveDataBase.updateTask(selectedTask.value);

      tasks(updatedTaskList);
    } catch (e) {
      return;
    }
  }

  Future<void> deleteTask() async {
    try {
      tasks.clear();
      List<TaskModel> updatedTaskList =
          await _hiveDataBase.deleteTask(selectedTask.value);

      tasks(updatedTaskList);
    } catch (e) {
      return;
    }
  }

  setTaskSelected(TaskModel task) {
    selectedTask.update((val) {
      val?.id = task.id;
      val?.title = task.title;
      val?.description = task.description;
      val?.deadline = task.deadline;
      val?.isImportant = task.isImportant;
    });
    titleController.text = task.title;
    descriptionController.text = task.description;
  }

  setTaskImportance(bool isImportant) {
    selectedTask.update((val) {
      val?.isImportant = isImportant;
    });
  }

  setTaskTitle(String title) {
    selectedTask.update((val) {
      val?.title = title;
    });
  }

  setTaskDescription(String description) {
    selectedTask.update((val) {
      val?.description = description;
    });
  }

  setTaskDeadline(String? time) {
    selectedTask.update((val) {
      val?.deadline = time;
    });
  }

  clearSelectedTask() => selectedTask.update((val) {
        descriptionController.clear();
        titleController.clear();
        val?.id = null;
        val?.title = "";
        val?.description = "";
        val?.deadline = null;
        val?.isImportant = false;
      });

  doLogOff() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }
}
