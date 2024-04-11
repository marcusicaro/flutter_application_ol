import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/weather.dart';
import 'package:flutter_application_1/utils/global_snackbar.dart';
import 'package:flutter_application_1/utils/login/custom_padding.dart';
import 'package:flutter_application_1/utils/login/text_field.dart';
import 'package:flutter_application_1/utils/login/mocks/auth_service.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.usernameController,
    required this.passwordController,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final TextEditingController usernameController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather app'),
      ),
      body: Form(
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
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      var authService = MockAuthService();
                      bool success = authService.login(
                        usernameController.text,
                        passwordController.text,
                      );
                      if (success) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const WeatherScreen()),
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
    );
  }
}
