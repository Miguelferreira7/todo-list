import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_list/model/task/task_model.dart';

class TaskDataBase {
  late Future<Isar?> db;

  TaskDataBase() {
    db = createDB();
  }

  Future<Isar?> createDB() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();

      return await Isar.open(
        [
          TaskEntitySchema
        ],
        inspector: true, directory: dir.path,
      );
    }
    return Isar.getInstance();
  }

  Future<List<TaskEntity>> getTasks() async {
    final isar = await db;

    try {
      final tasks = await isar?.taskEntitys.where().findAll();

    return tasks!;
    } catch (e) {
    return [];
    }
  }

  Future<List<TaskEntity>> saveTask(TaskEntity task) async {
    final isar = await db;

    await isar?.writeTxn(() async {
      await isar.taskEntitys.put(task); // inserir & atualizar
    });

    return await getTasks();
  }

  Future<List<TaskEntity>> deleteTask(TaskEntity task) async {
    final isar = await db;

    await isar?.writeTxn(() async {
      await isar.taskEntitys.delete(task.id);
    });
    return await getTasks();
  }
}