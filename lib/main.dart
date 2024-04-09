import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/login.dart';
import 'package:flutter_application_1/utils/geolocator.dart';
import 'package:flutter_application_1/utils/global_snackbar.dart';
import 'package:geolocator/geolocator.dart';

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
  bool? isLocationServiceEnabled;

  Future<void> initApp() async {
    try {
      await requestAccessToLocation();
    } catch (e) {
      GlobalSnackbar.show(e.toString());
      setState(() {
        isLocationServiceEnabled = false;
      });
      return;
    }

    bool locationServiceEnabled = await Geolocator.isLocationServiceEnabled();

    setState(() {
      isLocationServiceEnabled = locationServiceEnabled;
    });
  }

  @override
  void initState() {
    super.initState();
    initApp();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        scaffoldMessengerKey: GlobalSnackbar.key,
        title: 'Location Service',
        theme: ThemeData.dark(),
        home: _getHomeWidget(isLocationServiceEnabled, formKey, emailController,
            passwordController));
  }
}

Widget _getHomeWidget(
    isLocationServiceEnabled, formKey, emailController, passwordController) {
  if (isLocationServiceEnabled == true) {
    return LoginScreen(
      formKey: formKey,
      emailController: emailController,
      passwordController: passwordController,
    );
  }
  if (isLocationServiceEnabled == false) {
    return const Scaffold(
      body: Center(
        child: Text('Please allow access to your location'),
      ),
    );
  }
  return const Scaffold(
    body: Center(child: CircularProgressIndicator()),
  );
}
