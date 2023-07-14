import 'package:get/get.dart';
import 'package:todo_list/controller/authentication_controller.dart';
import 'package:todo_list/controller/task_controller.dart';

class ControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TaskController());
    Get.lazyPut(() => AuthenticationController());
  }
}
