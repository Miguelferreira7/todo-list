import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/controller/authentication_controller.dart';
import 'package:todo_list/view/authentication/sign_up_page.dart';
import 'package:todo_list/view/task/task_list_page.dart';

class SignInPage extends StatelessWidget {
  static const String route = "auth/sign-in";

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  final _pageKey = GlobalKey();
  final _formKey = GlobalKey<FormState>();

  final _authController = Get.find<AuthenticationController>();

  SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _pageKey,
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * .08,
        centerTitle: true,
        title: const Text("Entrar"),
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
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
                "Entrar",
                style: Theme.of(context).textTheme.button,
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  bool userIsSignned = await _authController.signInUser(
                    _controllerEmail.value.text.trim(),
                    _controllerPassword.value.text.trim(),
                  );

                  if (!userIsSignned) {
                    Get.snackbar(
                      "Erro ao logar",
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
        ),
        Container(
          alignment: Alignment.topCenter,
          child: GestureDetector(
            onTap: () => Navigator.of(context).pushNamed(SignUpPage.route),
            child: const Text(
              "Não possui conta? Cadastre-se clicando AQUI.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }
}
