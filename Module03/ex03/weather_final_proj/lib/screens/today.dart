import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';
import 'package:fl_chart/fl_chart.dart';
import '../components/weather_forecast_api.dart';
import 'errorpage.dart';

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
    // 初期表示 or エラーメッセージ
    if (widget.errorText != null || widget.forecast == null) {
      return ErrorDisplay(errorText: widget.errorText);
    }

    final String weatherString = getWeatherString(
        widget.forecast?.forecastData['current']['weather_code']);
    final String cityName =
        "${widget.geoData['name']}, ${widget.geoData['country']}";

    List<FlSpot> temperature = [];
    for (int i = 0; i < 24; i++) {
      temperature.add(FlSpot(i.toDouble(),
          widget.forecast?.forecastData['hourly']['temperature_2m'][i]));
      // sprintf("%02i:00", [i]);
      // ${widget.forecast?.forecastData['hourly']['temperature_2m'][i]}
      // ${widget.forecast?.forecastData['hourly_units']['temperature_2m']}
      // ${widget.forecast?.forecastData['hourly']['wind_speed_10m'][i]}
      // ${widget.forecast?.forecastData['hourly_units']['wind_speed_10m']}
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
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
              height: 40,
            ),
            AspectRatio(
              aspectRatio: 2.5,
              child: LineChart(
                LineChartData(
                  lineBarsData: [
                    LineChartBarData(spots: temperature),
                  ],
                ),
                // swapAnimationDuration: Duration(milliseconds: 150),
                // swapAnimationCurve: Curves.linear,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
