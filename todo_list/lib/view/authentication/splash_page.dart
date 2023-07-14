import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/utils/firebase/firebase_api_keys.dart';
import 'package:todo_list/view/authentication/sign_in_page.dart';
import 'package:todo_list/view/task/task_list_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);
  static const String route = "/splash-page";

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    _verifyUserState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Future<void> _verifyUserState() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userEmail =
        sharedPreferences.getString(AuthenticationApiKeys.USER_EMAIL);

    if (userEmail == null) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(SignInPage.route, (route) => false);
    } else {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(TaskListPage.route, (route) => false);
    }
  }
}
