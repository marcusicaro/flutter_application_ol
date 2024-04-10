import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/weather.dart';
import 'package:flutter_application_1/utils/global_snackbar.dart';
import 'package:flutter_application_1/utils/mock/auth_service.dart';

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
        backgroundColor: const Color.fromARGB(106, 255, 193, 7),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "Login"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "Password"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16.0),
                child: Center(
                    child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      var authService = MockAuthService();
                      bool success = await authService.login(
                        usernameController.text,
                        passwordController.text,
                      );
                      if (success) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WeatherScreen()),
                        );
                      } else {
                        GlobalSnackbar.show('Invalid credentials');
                      }
                    } else {
                      GlobalSnackbar.show('Please enter your credentials');
                    }
                  },
                  child: const Text('Submit'),
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
