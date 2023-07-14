import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:todo_list/injection/getx_binding.dart';
import 'package:todo_list/utils/main_theme.dart';
import 'package:todo_list/view/authentication/sign_in_page.dart';
import 'package:todo_list/view/authentication/sign_up_page.dart';
import 'package:todo_list/view/task/task_list_page.dart';
import 'package:todo_list/view/task/task_page.dart';
import 'view/authentication/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'To Do List - Miguel Ferreira',
      initialBinding: ControllerBinding(),
      debugShowCheckedModeBanner: false,
      theme: MainTheme.defaultTheme,
      initialRoute: SplashPage.route,
      routes: {
        SplashPage.route: (context) => const SplashPage(),
        SignInPage.route: (context) => SignInPage(),
        SignUpPage.route: (context) => SignUpPage(),
        TaskListPage.route: (context) => TaskListPage(),
        TaskPage.route: (context) => TaskPage()
      },
    );
  }
}
