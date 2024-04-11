import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/login.dart';
import 'package:flutter_application_1/utils/custom_future_builder.dart';
import 'package:flutter_application_1/utils/request_access_to_location.dart';
import 'package:flutter_application_1/utils/global_snackbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late Future<dynamic> _deviceLocationAccessStatus;

  @override
  void initState() {
    super.initState();
    _deviceLocationAccessStatus = initializeLocationServices();
  }

  Future<void> initializeLocationServices() async {
    return await requestAccessToLocation();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: GlobalSnackbar.key,
      title: 'Location Service',
      theme: ThemeData.light(),
      home: CustomFutureBuilder(
        future: _deviceLocationAccessStatus,
        errorMessage: 'This app requires access to your device location.',
        buildSuccessState: (context, snapshot) => LoginScreen(
          formKey: formKey,
          usernameController: emailController,
          passwordController: passwordController,
        ),
      ),
    );
  }
}
