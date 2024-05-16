import 'package:flutter/material.dart';
import '../components/weather_forecast_api.dart';

class WeeklyTab extends StatefulWidget {
  final Map<String, dynamic> geoData;
  final WeatherForecast? forecast;
  final String? errorText;

  const WeeklyTab({
    super.key,
    this.geoData = const {},
    this.forecast,
    this.errorText,
  });

  @override
  WeeklyTabState createState() => WeeklyTabState();
}

class WeeklyTabState extends State<WeeklyTab> {
  WeatherForecast? forecast;

  @override
  Widget build(BuildContext context) {
    String weatherText;
    bool errorFlag = false;

    if (widget.errorText != null) {
      weatherText = widget.errorText!;
      errorFlag = true;
    } else if (widget.forecast != null) {
      weatherText = """
City: ${widget.geoData['name']}
Country: ${widget.geoData['country']}
""";
      for (int i = 0; i < 7; i++) {
        weatherText += "${widget.forecast?.forecastData['daily']['time'][i]}";
        weatherText += "          ";
        weatherText +=
            "${widget.forecast?.forecastData['daily']['temperature_2m_min'][i]}${widget.forecast?.forecastData['daily_units']['temperature_2m_min']}";
        weatherText += "          ";
        weatherText +=
            "${widget.forecast?.forecastData['daily']['temperature_2m_max'][i]}${widget.forecast?.forecastData['daily_units']['temperature_2m_max']}";
        weatherText += "          ";
        weatherText += getWeatherString(
            widget.forecast?.forecastData['daily']['weather_code'][i]);
        weatherText += "\n";
      }
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
