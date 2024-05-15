import 'package:flutter/material.dart';
import '../components/weather_forecast_api.dart';

class WeeklyTab extends StatefulWidget {
  final Map<String, dynamic> geoData;
  final String? errorText;

  const WeeklyTab({
    super.key,
    this.geoData = const {},
    this.errorText,
  });

  @override
  WeeklyTabState createState() => WeeklyTabState();
}

class WeeklyTabState extends State<WeeklyTab> {
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
            for (int i = 0; i < 7; i++) {
              children += "${forecast?.forecastData['daily']['time'][i]}";
              children += "          ";
              children +=
                  "${forecast?.forecastData['daily']['temperature_2m_min'][i]}${forecast?.forecastData['daily_units']['temperature_2m_min']}";
              children += "          ";
              children +=
                  "${forecast?.forecastData['daily']['temperature_2m_max'][i]}${forecast?.forecastData['daily_units']['temperature_2m_max']}";
              children += "          ";
              children += getWeatherString(
                  forecast?.forecastData['daily']['weather_code'][i]);
              children += "\n";
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
