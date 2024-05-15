import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';
import '../components/weather_forecast_api.dart';

class TodayTab extends StatefulWidget {
  final Map<String, dynamic> geoData;
  final String? errorText;

  const TodayTab({
    super.key,
    this.geoData = const {},
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
    return Scaffold(
      body: Center(
          child: FutureBuilder<WeatherForecast?>(
        future: getForecast(),
        builder:
            (BuildContext context, AsyncSnapshot<WeatherForecast?> snapshot) {
          String children;
          bool errorFlag = false;
          if (widget.errorText != null) {
            children = widget.errorText!;
            errorFlag = true;
          } else if (snapshot.hasData) {
            String weatherString = getWeatherString(
                forecast?.forecastData['current']['weather_code']);
            children = """
Weather: $weatherString
City: ${widget.geoData['name']}
Country: ${widget.geoData['country']}
""";
            for (int i = 0; i < 24; i++) {
              children += sprintf("%02i:00", [i]);
              children += "          ";
              children += "${forecast?.forecastData['hourly']['temperature_2m'][i]}${forecast?.forecastData['hourly_units']['temperature_2m']}";
              children += "          ";
              children += "${forecast?.forecastData['hourly']['wind_speed_10m'][i]}${forecast?.forecastData['hourly_units']['wind_speed_10m']}\n";
            }
          } else if (snapshot.hasError) {
            children = 'Error: ${snapshot.error}';
            errorFlag = true;
          } else {
            children = '';
          }
          return Text(
            children,
            textAlign: TextAlign.center,
            style: errorFlag ? const TextStyle(color: Colors.red) : null,
          );
        },
      )),
    );
  }
}
