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
        // print(GeoLocator.getDetailText(position));
        return forecast;
      } else {
        return null;
      }
    } catch (error) {
      return null;
      // forecast.; error
    }
  }

  static String getWeatherString(int code) {
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
            print(forecast?.forecastData['current']['weather_code']);
            final weatherString = getWeatherString(
                forecast?.forecastData['current']['weather_code']);
            children = """
City: ${widget.geoData['name']}
Country: ${widget.geoData['country']}
Weather: $weatherString
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
