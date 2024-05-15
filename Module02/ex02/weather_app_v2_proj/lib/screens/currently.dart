import 'package:flutter/material.dart';
import '../components/weather_forecast_api.dart';

class CurrentlyTab extends StatefulWidget {
  final Map<String, dynamic> geoData;
  final String? errorText;

  const CurrentlyTab({
    super.key,
    this.geoData = const {},
    this.errorText,
  });

  @override
  CurrentlyTabState createState() => CurrentlyTabState();
}

class CurrentlyTabState extends State<CurrentlyTab> {
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
            final weatherString = getWeatherString(
                forecast?.forecastData['current']['weather_code']);
            children = """
Weather: $weatherString
City: ${widget.geoData['name']}
Country: ${widget.geoData['country']}
Temperature: ${forecast?.forecastData['current']['temperature_2m']}${forecast?.forecastData['current_units']['temperature_2m']}
Wind speed: ${forecast?.forecastData['current']['wind_speed_10m']}${forecast?.forecastData['current_units']['wind_speed_10m']}
            """;
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
