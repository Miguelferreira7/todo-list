import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

import '../../controller/authentication_controller.dart';
import '../task/task_list_page.dart';

class SignUpPage extends StatelessWidget {
  static const String route = "auth/sign-up-step-one";

  final _authController = Get.find<AuthenticationController>();
  final _pageKey = GlobalKey();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _pageKey,
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * .14,
        centerTitle: true,
        title: const Text("Cadastre-se"),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 1.4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildForms(context),
              _buildBottomButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForms(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 32, right: 32),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              height: MediaQuery.of(context).size.height * .06,
              width: MediaQuery.of(context).size.width * .8,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextFormField(
                controller: _controllerEmail,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: 'E-mail',
                  hintStyle: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                validator: (value) {
                  if (value == "") {
                    return "E-mail é obrigatório";
                  }
                  if (!value!.contains("@") && !value.contains(".com")) {
                    return "Digite um email valido";
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 4),
              height: MediaQuery.of(context).size.height * .06,
              width: MediaQuery.of(context).size.width * .8,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextFormField(
                controller: _controllerPassword,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Senha',
                  hintStyle: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                validator: (value) {
                  if (value == "") {
                    return "A senha é obrigatória";
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomButtons(BuildContext context) {
    return SizedBox(
      child: Container(
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
            "Cadastrar",
            style: Theme.of(context).textTheme.button,
          ),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              bool userCreated = await _authController.signUpUser(
                _controllerEmail.value.text.trim(),
                _controllerPassword.value.text.trim(),
              );

              if (!userCreated) {
                Get.snackbar(
                  "Erro ao cadastrar conta",
                  _authController.firebaseErrorMessage.value,
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                );
                return;
              }

              Navigator.of(context).pushNamedAndRemoveUntil(
                  TaskListPage.route, (route) => false);
            }
            return;
          },
        ),
      ),
    );
  }
}
