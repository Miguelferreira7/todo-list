import 'package:hive/hive.dart';
import 'package:todo_list/model/task_model.dart';

class HiveDataBase {

  HiveDataBase() {
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(TaskAdapter());
    }
    await Hive.openBox('tasks');
  }

  Future<List<TaskModel>> getTasks() async {
    final box = await Hive.openBox('tasks');

    List<TaskModel> tasks = [];
    for (var element in box.keys) {
      tasks.add(await box.get(element));
    }
    return tasks;
  }

  Future<List<TaskModel>> createTask(TaskModel task) async {
    final box = await Hive.openBox('tasks');

    await box.put(task.id, task);
    return await getTasks();
  }

  Future<List<TaskModel>> updateTask(TaskModel task) async {
    final box = await Hive.openBox('tasks');

    await box.put(task.id, task);
    return await getTasks();
  }

  Future<List<TaskModel>> deleteTask(TaskModel task) async {
    final box = await Hive.openBox('tasks');

    await box.delete(task.id);
    return await getTasks();
  }
}