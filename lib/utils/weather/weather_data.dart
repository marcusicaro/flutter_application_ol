import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';

class WeatherData {
  late String temperature;
  late String currently;
  late String humidity;
  late String windSpeed;

  Future fetchWeatherData(http.Client client, Position position) async {
    const apiKey = String.fromEnvironment('API_KEY',
        defaultValue: '553668e995f051c41337492028b87231');
    http.Response response = await client.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&appid=$apiKey&units=imperial'));
    var weatherData = jsonDecode(response.body);
    return weatherData;
  }

  Future setWeatherData(http.Client client, Position position) async {
    dynamic weatherData = await fetchWeatherData(client, position);

    temperature = weatherData['main']['temp'].toString();
    currently = weatherData['weather'][0]['main'];
    humidity = weatherData['main']['humidity'].toString();
    windSpeed = weatherData['wind']['speed'].toString();
  }
}
