import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

part 'task_model.g.dart';

@collection
class TaskEntity {

  Id id = Isar.autoIncrement;

  late bool isImportant = false;

  String title;

  String description;

  String? deadline;

  String? image;

  TaskEntity({
    required this.id,
    required this.image,
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

  Uint8List? getImageFile() {
    if (image == null || image!.isEmpty) {
      return null;
    }

    return base64Decode(image!);
  }
}
