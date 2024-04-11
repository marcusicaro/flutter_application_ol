import 'package:flutter_application_1/utils/weather/weather_data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:geolocator/geolocator.dart';

import 'fetch_weather_test.mocks.dart';

@GenerateMocks([http.Client, Position])
void main() {
  group('WeatherData', () {
    test(
        'fetchWeatherData returns weather data if the http call completes successfully',
        () async {
      final client = MockClient();
      final position = MockPosition();

      when(position.latitude).thenReturn(37.7749); // Mock latitude
      when(position.longitude).thenReturn(-122.4194); // Mock longitude

      when(client.get(any)).thenAnswer((_) async => http.Response(
          '{"main": {"temp": 70, "humidity": 80}, "weather": [{"main": "Clear"}], "wind": {"speed": 5}}',
          200));

      var weatherData = WeatherData();
      var result = await weatherData.fetchWeatherData(client, position);

      expect(result, isNotNull);
      expect(result['main']['temp'], 70);
      expect(result['main']['humidity'], 80);
      expect(result['weather'][0]['main'], 'Clear');
      expect(result['wind']['speed'], 5);
    });

    test('setWeatherData sets weather data correctly', () async {
      final client = MockClient();
      final position = MockPosition();

      when(position.latitude).thenReturn(37.7749); // Mock latitude
      when(position.longitude).thenReturn(-122.4194); // Mock longitude

      when(client.get(any)).thenAnswer((_) async => http.Response(
          '{"main": {"temp": 70, "humidity": 80}, "weather": [{"main": "Clear"}], "wind": {"speed": 5}}',
          200));

      var weatherData = WeatherData();
      await weatherData.setWeatherData(client, position);

      expect(weatherData.temperature, '70');
      expect(weatherData.currently, 'Clear');
      expect(weatherData.humidity, '80');
      expect(weatherData.windSpeed, '5');
    });
  });
}
