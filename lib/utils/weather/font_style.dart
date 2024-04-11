import 'package:flutter/material.dart';

class WeatherText extends StatelessWidget {
  final String label;
  final String value;

  const WeatherText({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    double fontSize = MediaQuery.of(context).size.width * 0.05;
    return Text(
      '$label: $value',
      style: TextStyle(fontSize: fontSize),
    );
  }
}
