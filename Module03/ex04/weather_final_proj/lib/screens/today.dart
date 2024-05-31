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
  final _scrolllController = ScrollController();

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
    double minY = 0;
    double maxY = 0;
    List<Widget> hourlyWidgets = [];
    for (int i = 0; i < 24; i++) {
      temperature.add(FlSpot(i.toDouble(),
          widget.forecast?.forecastData['hourly']['temperature_2m'][i]));
      if (i == 0 ||
          minY > widget.forecast?.forecastData['hourly']['temperature_2m'][i]) {
        minY = widget.forecast?.forecastData['hourly']['temperature_2m'][i];
      }
      if (i == 0 ||
          maxY < widget.forecast?.forecastData['hourly']['temperature_2m'][i]) {
        maxY = widget.forecast?.forecastData['hourly']['temperature_2m'][i];
      }
      hourlyWidgets.add(
        Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(sprintf("%02i:00", [i])),
              getWeatherIcon(
                  widget.forecast?.forecastData['hourly']['weather_code'][i],
                  iconSize: 32.0),
              Text(
                "${widget.forecast?.forecastData['hourly']['temperature_2m'][i]}${widget.forecast?.forecastData['hourly_units']['temperature_2m']}",
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.air,
                    color: Colors.blue,
                    size: 16.0,
                    semanticLabel: 'wind',
                  ),
                  Text(
                    "${widget.forecast?.forecastData['hourly']['wind_speed_10m'][i]}${widget.forecast?.forecastData['hourly_units']['wind_speed_10m']}",
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: SingleChildScrollView(
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
                aspectRatio: 2.1,
                child: LineChart(
                  LineChartData(
                    titlesData: FlTitlesData(
                      topTitles: const AxisTitles(
                        axisNameWidget: Text(
                          'Today temperatures',
                          style: TextStyle(height: -2.0),
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          getTitlesWidget: (value, meta) => SideTitleWidget(
                            axisSide: meta.axisSide,
                            child: Text(
                              "${value.toInt().toString()}${widget.forecast?.forecastData['hourly_units']['temperature_2m']}",
                            ),
                          ),
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          getTitlesWidget: (value, meta) {
                            final int hours = value.toInt();
                            return SideTitleWidget(
                              axisSide: meta.axisSide,
                              child: hours % 2 == 0
                                  ? Text(sprintf("%02i:00", [hours]))
                                  : const Text(''),
                            );
                          },
                        ),
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 10,
                          getTitlesWidget: (value, meta) => const Text(''),
                        ),
                      ),
                    ),
                    minY: (minY - 1).round().toDouble(),
                    maxY: (maxY + 1).round().toDouble(),
                    borderData: FlBorderData(),
                    lineBarsData: [
                      LineChartBarData(spots: temperature),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Scrollbar(
                controller: _scrolllController,
                child: SingleChildScrollView(
                  controller: _scrolllController,
                  scrollDirection: Axis.horizontal,
                  child: Row(children: hourlyWidgets),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
