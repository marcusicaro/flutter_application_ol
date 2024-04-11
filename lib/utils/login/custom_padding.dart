import 'package:flutter/material.dart';

class CustomPadding extends StatelessWidget {
  final Widget child;

  const CustomPadding({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: child,
    );
  }
}
