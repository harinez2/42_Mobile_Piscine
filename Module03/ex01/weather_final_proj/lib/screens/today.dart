import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';
import '../components/weather_forecast_api.dart';

class TodayTab extends StatefulWidget {
  final Map<String, dynamic> geoData;
  final WeatherForecast? forecast;
  final String? errorText;

  const TodayTab({
    super.key,
    this.geoData = const {},
    this.forecast,
    this.errorText,
  });

  @override
  TodayTabState createState() => TodayTabState();
}

class TodayTabState extends State<TodayTab> {
  WeatherForecast? forecast;

  Future<WeatherForecast?> getForecast() async {
    try {
      if (widget.geoData != {}) {
        forecast = await fetchForecastCurrent(
            widget.geoData['latitude'], widget.geoData['longitude']);
        return forecast;
      } else {
        return null;
      }
    } catch (error) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    String weatherText;
    bool errorFlag = false;

    if (widget.errorText != null) {
      weatherText = widget.errorText!;
      errorFlag = true;
    } else if (widget.forecast != null) {
      final String weatherString = getWeatherString(
          widget.forecast?.forecastData['current']['weather_code']);
      weatherText = """
Weather: $weatherString
City: ${widget.geoData['name']}
Country: ${widget.geoData['country']}
""";
      for (int i = 0; i < 24; i++) {
        weatherText += sprintf("%02i:00", [i]);
        weatherText += "          ";
        weatherText +=
            "${widget.forecast?.forecastData['hourly']['temperature_2m'][i]}${widget.forecast?.forecastData['hourly_units']['temperature_2m']}";
        weatherText += "          ";
        weatherText +=
            "${widget.forecast?.forecastData['hourly']['wind_speed_10m'][i]}${widget.forecast?.forecastData['hourly_units']['wind_speed_10m']}\n";
      }
    } else {
      weatherText = '';
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Text(
          weatherText,
          textAlign: TextAlign.center,
          style: errorFlag ? const TextStyle(color: Colors.red) : null,
        ),
      ),
    );
  }
}
