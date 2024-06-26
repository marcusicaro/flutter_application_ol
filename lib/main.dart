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
      theme: ThemeData.dark().copyWith(
        appBarTheme: AppBarTheme(
            color: Theme.of(context).colorScheme.primary,
            foregroundColor: Colors.white),
        colorScheme: ColorScheme.light(
            primary: Theme.of(context).colorScheme.primary,
            background: Colors.white),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Weather App'),
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
                      buildSuccessState: (context, snapshot) =>
                          const LoginScreen(),
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
