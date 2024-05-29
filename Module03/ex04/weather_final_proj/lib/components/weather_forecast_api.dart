import 'package:flutter/material.dart';
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
      '$weatherForecastApiRoute?latitude=$latitude&longitude=$longitude&timezone=Asia%2FTokyo&current=temperature_2m,weather_code,wind_speed_10m&hourly=temperature_2m,wind_speed_10m,weather_code&daily=weather_code,temperature_2m_max,temperature_2m_min'));
  if (res.statusCode == 200) {
    return WeatherForecast.fromJson(jsonDecode(res.body));
  } else {
    throw Exception('Failed to Load WeatherForecast');
  }
}

String getWeatherString(int code) {
  if (code == 0) {
    return 'Clear sky';
  } else if (code == 1 || code == 2 || code == 3) {
    return 'Mainly clear, partly cloudy, and overcast';
  } else if (code == 45 || code == 48) {
    return 'Fog and depositing rime fog';
  } else if (code == 51 || code == 53 || code == 55) {
    return 'Drizzle: Light, moderate, and dense intensity';
  } else if (code == 56 || code == 57) {
    return 'Freezing Drizzle: Light and dense intensity';
  } else if (code == 61 || code == 63 || code == 65) {
    return 'Rain: Slight, moderate and heavy intensity';
  } else if (code == 66 || code == 67) {
    return 'Freezing Rain: Light and heavy intensity';
  } else if (code == 71 || code == 73 || code == 75) {
    return 'Snow fall: Slight, moderate, and heavy intensity';
  } else if (code == 77) {
    return 'Snow grains';
  } else if (code == 80 || code == 81 || code == 82) {
    return 'Rain showers: Slight, moderate, and violent';
  } else if (code == 85 || code == 86) {
    return 'Snow showers slight and heavy';
  } else if (code == 95) {
    return 'Thunderstorm: Slight or moderate';
  } else if (code == 96 || code == 99) {
    return 'Thunderstorm with slight and heavy hail';
  } else {
    return 'Undefined';
  }
}

Icon getWeatherIcon(int code, {double iconSize = 100.0}) {
  if (code == 0) {
    return Icon(
      Icons.sunny,
      color: Colors.pink,
      size: iconSize,
      semanticLabel: 'Clear sky',
    );
  } else if (code == 1 || code == 2 || code == 3) {
    return Icon(
      Icons.foggy,
      color: Colors.grey,
      size: iconSize,
      semanticLabel: 'Mainly clear, partly cloudy, and overcast',
    );
  } else if (code == 45 || code == 48) {
    return Icon(
      Icons.foggy,
      color: Colors.grey,
      size: iconSize,
      semanticLabel: 'Fog and depositing rime fog',
    );
  } else if (code == 51 || code == 53 || code == 55) {
    return Icon(
      Icons.ac_unit,
      color: Colors.lightBlue,
      size: iconSize,
      semanticLabel: 'Drizzle: Light, moderate, and dense intensity',
    );
  } else if (code == 56 || code == 57) {
    return Icon(
      Icons.ac_unit,
      color: Colors.lightBlue,
      size: iconSize,
      semanticLabel: 'Freezing Drizzle: Light and dense intensity',
    );
  } else if (code == 61 || code == 63 || code == 65) {
    return Icon(
      Icons.umbrella,
      color: Colors.blue,
      size: iconSize,
      semanticLabel: 'Rain: Slight, moderate and heavy intensity',
    );
  } else if (code == 66 || code == 67) {
    return Icon(
      Icons.umbrella,
      color: Colors.blue,
      size: iconSize,
      semanticLabel: 'Freezing Rain: Light and heavy intensity',
    );
  } else if (code == 71 || code == 73 || code == 75) {
    return Icon(
      Icons.cloudy_snowing,
      color: Colors.grey,
      size: iconSize,
      semanticLabel: 'Snow fall: Slight, moderate, and heavy intensity',
    );
  } else if (code == 77) {
    return Icon(
      Icons.snowing,
      color: Colors.lightBlue,
      size: iconSize,
      semanticLabel: 'Snow grains',
    );
  } else if (code == 80 || code == 81 || code == 82) {
    return Icon(
      Icons.umbrella,
      color: Colors.grey,
      size: iconSize,
      semanticLabel: 'Rain showers: Slight, moderate, and violent',
    );
  } else if (code == 85 || code == 86) {
    return Icon(
      Icons.cloudy_snowing,
      color: Colors.grey,
      size: iconSize,
      semanticLabel: 'Snow showers slight and heavy',
    );
  } else if (code == 95) {
    return Icon(
      Icons.thunderstorm,
      color: Colors.grey,
      size: iconSize,
      semanticLabel: 'Thunderstorm: Slight or moderate',
    );
  } else if (code == 96 || code == 99) {
    return Icon(
      Icons.thunderstorm,
      color: Colors.grey,
      size: iconSize,
      semanticLabel: 'Thunderstorm with slight and heavy hail',
    );
  } else {
    return Icon(
      Icons.check_box_outline_blank,
      color: Colors.grey,
      size: iconSize,
      semanticLabel: 'Undefined',
    );
  }
}
