import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/global_snackbar.dart';
import 'package:flutter_application_1/utils/login/custom_padding.dart';
import 'package:flutter_application_1/utils/login/text_field.dart';
import 'package:flutter_application_1/utils/login/mocks/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: Form(
          key: _formKey,
          child: CustomPadding(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomTextField(
                  controller: usernameController,
                  labelText: "Username",
                  validationMessage: 'Please enter your username',
                ),
                CustomTextField(
                  controller: passwordController,
                  labelText: "Password",
                  validationMessage: 'Please enter your password',
                  obscureText: true,
                ),
                CustomPadding(
                  child: Center(
                      child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        var authService = MockAuthService();
                        bool success = authService.login(
                          usernameController.text,
                          passwordController.text,
                        );
                        if (success) {
                          Navigator.pushNamed(
                            context,
                            '/weather',
                          );
                        } else {
                          GlobalSnackbar.show('Invalid credentials');
                        }
                      } else {
                        GlobalSnackbar.show('Please enter your credentials');
                      }
                    },
                    child: const Text('Login'),
                  )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
