import 'dart:convert';
import 'package:http/http.dart' as http;

// API Reference  https://open-meteo.com/en/docs

const String weatherForecastApiRoute = "https://api.open-meteo.com/v1/forecast";

class WeatherForecast {
  final Map<String, dynamic> forecastData;

  WeatherForecast({
    required this.forecastData,
  });

  factory WeatherForecast.fromJson(Map<String, dynamic>? json) {
    if (json == null || json['generationtime_ms'] == null) {
      return WeatherForecast(forecastData: {});
    }
    return WeatherForecast(
      forecastData: Map<String, dynamic>.from(json),
    );
  }
}

Future<WeatherForecast> fetchForecastCurrent(
    double latitude, double longitude) async {
  final res = await http.get(Uri.parse(
      '$weatherForecastApiRoute?latitude=$latitude&longitude=$longitude&current=temperature_2m,weather_code,wind_speed_10m&hourly=temperature_2m'));
  if (res.statusCode == 200) {
    return WeatherForecast.fromJson(jsonDecode(res.body));
  } else {
    throw Exception('Failed to Load WeatherForecast');
  }
}
