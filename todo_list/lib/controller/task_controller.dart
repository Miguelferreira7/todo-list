import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:isar/isar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/model/task/task_model.dart';
import '../database/repository.dart';

class TaskController extends GetxController {
  @override
  void onInit() {
    getAllTasks();
    super.onInit();
  }

  final TaskDataBase _hiveDataBase = TaskDataBase();

  final tasks = <TaskEntity>[].obs;
  final selectedTask = TaskEntity(
          id: Isar.autoIncrement,
          title: "",
          description: "",
          isImportant: false,
          deadline: null,
          image: null)
      .obs;

  File? selectedImage;
  final picker = ImagePicker();
  final inProcess = false.obs;

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

      List<TaskEntity> updatedTaskList =
          await _hiveDataBase.saveTask(selectedTask.value);

      tasks(updatedTaskList);
    } catch (e) {
      return;
    }
  }

  Future<void> deleteTask() async {
    try {
      tasks.clear();
      List<TaskEntity> updatedTaskList =
          await _hiveDataBase.deleteTask(selectedTask.value);

      tasks(updatedTaskList);
    } catch (e) {
      return;
    }
  }

  setTaskSelected(TaskEntity task) {
    selectedTask.update((val) {
      val?.id = task.id;
      val?.title = task.title;
      val?.description = task.description;
      val?.deadline = task.deadline;
      val?.isImportant = task.isImportant;
      val?.image = task.image;
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

  getImageFromGallery(ImageSource src) async {
    try {
      inProcess(true);
      final pickedFile = await picker.pickImage(source: src);
      if (pickedFile != null) {
        selectedImage = File(pickedFile.path);

        selectedTask.update((val) {
          val?.image = base64Encode(selectedImage!.readAsBytesSync());
        });

        inProcess(false);
      } else {
        inProcess(false);
      }
    } catch (e) {
      inProcess(false);
      return;
    }
  }

  clearSelectedTask() => selectedTask.update((val) {
        descriptionController.clear();
        titleController.clear();
        val?.id = Isar.autoIncrement;
        val?.title = "";
        val?.description = "";
        val?.deadline = null;
        val?.isImportant = false;
        val?.image = null;
      });

  doLogOff() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }
}
