import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 1, adapterName: "TaskAdapter")
class TaskModel {

  @HiveField(0)
  String? id;

  @HiveField(1)
  late bool isImportant = false;

  @HiveField(2)
  String title;

  @HiveField(3)
  String description;

  @HiveField(4)
  String? deadline;

  TaskModel({
    required this.id,
    required this.isImportant,
    required this.title,
    required this.description,
    required this.deadline,
  });

  String getDeadline(BuildContext context) {
    if (deadline == null) {
      return TimeOfDay.now().format(context);
    }

    return deadline!;
  }
}
