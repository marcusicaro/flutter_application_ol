import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/login/custom_padding.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String validationMessage;
  final bool obscureText;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.validationMessage,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPadding(
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: labelText,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return validationMessage;
          }
          return null;
        },
      ),
    );
  }
}
