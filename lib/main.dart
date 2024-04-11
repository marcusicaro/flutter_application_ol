import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/login.dart';
import 'package:flutter_application_1/screens/weather.dart';
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: GlobalSnackbar.key,
      title: 'Location Service',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.blue,
        appBarTheme: const AppBarTheme(
            color: Colors.blue, foregroundColor: Colors.white),
        colorScheme: const ColorScheme.light(
            primary: Colors.blue, background: Colors.white),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Location Service'),
        ),
        body: Navigator(
          initialRoute: '/',
          onGenerateRoute: (RouteSettings settings) {
            WidgetBuilder builder;
            switch (settings.name) {
              case '/':
                builder = (BuildContext _) => CustomFutureBuilder(
                      future: _deviceLocationAccessStatus,
                      errorMessage:
                          'This app requires access to your device location.',
                      buildSuccessState: (context, snapshot) => LoginScreen(
                        formKey: formKey,
                        usernameController: emailController,
                        passwordController: passwordController,
                      ),
                    );
                break;
              case '/weather':
                builder = (BuildContext _) => const WeatherScreen();
                break;
              default:
                throw Exception('Invalid route: ${settings.name}');
            }
            return MaterialPageRoute(builder: builder, settings: settings);
          },
        ),
      ),
    );
  }
}
