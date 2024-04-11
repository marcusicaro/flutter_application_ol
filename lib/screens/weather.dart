import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/custom_future_builder.dart';
import 'package:flutter_application_1/utils/weather/font_style.dart';
import 'package:flutter_application_1/utils/weather/weather_data.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  WeatherScreenState createState() => WeatherScreenState();
}

class WeatherScreenState extends State<WeatherScreen> {
  WeatherData weatherData = WeatherData();
  late Future<void> _updateWeatherDataFuture;

  updateWeatherData() async {
    Position position = await Geolocator.getCurrentPosition();
    http.Client client = http.Client();
    await weatherData.setWeatherData(client, position);
  }

  @override
  void initState() {
    super.initState();
    _updateWeatherDataFuture = updateWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return CustomFutureBuilder(
      future: _updateWeatherDataFuture,
      errorMessage:
          'It was not possible to get the weather conditions. Please verify your connection.',
      buildSuccessState: (context, snapshot) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            WeatherText(
              label: 'Temperature',
              value: '${weatherData.temperature}°F',
            ),
            WeatherText(
              label: 'Weather',
              value: weatherData.currently,
            ),
            WeatherText(
              label: 'Humidity',
              value: '${weatherData.humidity} %',
            ),
            WeatherText(
              label: 'Wind Speed',
              value: '${weatherData.windSpeed} miles/hour',
            ),
          ],
        ),
      ),
    );
  }
}
