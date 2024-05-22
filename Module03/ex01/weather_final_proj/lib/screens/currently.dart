import 'package:flutter/material.dart';
import '../components/weather_forecast_api.dart';

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
Temperature: ${widget.forecast?.forecastData['current']['temperature_2m']}${widget.forecast?.forecastData['current_units']['temperature_2m']}
Wind speed: ${widget.forecast?.forecastData['current']['wind_speed_10m']}${widget.forecast?.forecastData['current_units']['wind_speed_10m']}
            """;
    } else {
      weatherText = '';
    }

    return Scaffold(
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
