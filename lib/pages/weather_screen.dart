import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  var temperature;
  var description;
  var currently;
  var humidity;
  var windSpeed;

  Future getWeather() async {
    const API_KEY = String.fromEnvironment('API_KEY');
    Position position = await Geolocator.getCurrentPosition();
    http.Response response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&appid=${API_KEY}&units=imperial'));
    var results = jsonDecode(response.body);
    setState(() {
      this.temperature = results['main']['temp'];
      this.description = results['weather'][0]['description'];
      this.currently = results['weather'][0]['main'];
      this.humidity = results['main']['humidity'];
      this.windSpeed = results['wind']['speed'];
    });
  }

  @override
  void initState() {
    super.initState();
    this.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: Column(
        children: <Widget>[
          Text('Temperature: $temperature°F'),
          Text('Weather: $currently'),
          Text('Humidity: $humidity %'),
          Text('Wind Speed: $windSpeed miles/hour'),
        ],
      ),
    );
  }
}
