import 'package:flutter/material.dart';
import '../components/weather_forecast_api.dart';
import 'errorpage.dart';

class CurrentlyTab extends StatefulWidget {
  final Map<String, dynamic> geoData;
  final WeatherForecast? forecast;
  final String? errorText;

  const CurrentlyTab({
    super.key,
    this.geoData = const {},
    this.forecast,
    this.errorText,
  });

  @override
  CurrentlyTabState createState() => CurrentlyTabState();
}

class CurrentlyTabState extends State<CurrentlyTab> {
  @override
  Widget build(BuildContext context) {
    // 初期表示 or エラーメッセージ
    if (widget.errorText != null || widget.forecast == null) {
      return ErrorDisplay(errorText: widget.errorText);
    }

    final String weatherString = getWeatherString(
        widget.forecast?.forecastData['current']['weather_code']);
    final String cityName =
        "${widget.geoData['name']}, ${widget.geoData['country']}";
    final String currentDegree =
        "${widget.forecast?.forecastData['current']['temperature_2m']}${widget.forecast?.forecastData['current_units']['temperature_2m']}";
    final String windSpeed =
        "${widget.forecast?.forecastData['current']['wind_speed_10m']}${widget.forecast?.forecastData['current_units']['wind_speed_10m']}";
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              weatherString,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.blue,
              ),
            ),
            Text(
              cityName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 70,
            ),
            Text(
              currentDegree,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 48,
                color: Colors.orange,
              ),
            ),
            getWeatherIcon(
                widget.forecast?.forecastData['current']['weather_code']),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.air,
                    color: Colors.blue,
                    size: 16.0,
                    semanticLabel: 'wind',
                  ),
                  Text(
                    windSpeed,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
