import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../components/weather_forecast_api.dart';
import 'errorpage.dart';

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
    // 初期表示 or エラーメッセージ
    if (widget.errorText != null || widget.forecast == null) {
      return ErrorDisplay(errorText: widget.errorText);
    }

    final String weatherString = getWeatherString(
        widget.forecast?.forecastData['current']['weather_code']);
    final String cityName =
        "${widget.geoData['name']}, ${widget.geoData['country']}";

    List<FlSpot> temperatureMin = [];
    List<FlSpot> temperatureMax = [];
    double minY = 0;
    double maxY = 0;
    List<Widget> dailyWidgets = [];
    for (int i = 0; i < 7; i++) {
      temperatureMin.add(FlSpot(i.toDouble(),
          widget.forecast?.forecastData['daily']['temperature_2m_min'][i]));
      if (i == 0 ||
          minY >
              widget.forecast?.forecastData['daily']['temperature_2m_min'][i]) {
        minY = widget.forecast?.forecastData['daily']['temperature_2m_min'][i];
      }
      if (i == 0 ||
          maxY <
              widget.forecast?.forecastData['daily']['temperature_2m_min'][i]) {
        maxY = widget.forecast?.forecastData['daily']['temperature_2m_min'][i];
      }
      temperatureMax.add(FlSpot(i.toDouble(),
          widget.forecast?.forecastData['daily']['temperature_2m_max'][i]));
      if (minY >
          widget.forecast?.forecastData['daily']['temperature_2m_max'][i]) {
        minY = widget.forecast?.forecastData['daily']['temperature_2m_max'][i];
      }
      if (maxY <
          widget.forecast?.forecastData['daily']['temperature_2m_max'][i]) {
        maxY = widget.forecast?.forecastData['daily']['temperature_2m_max'][i];
      }
      DateTime date =
          DateTime.parse(widget.forecast?.forecastData['daily']['time'][i]);
      dailyWidgets.add(
        Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text('${date.month}/${date.day}'),
              getWeatherIcon(
                  widget.forecast?.forecastData['daily']['weather_code'][i],
                  iconSize: 32.0),
              Text(
                "${widget.forecast?.forecastData['daily']['temperature_2m_max'][i]}${widget.forecast?.forecastData['daily_units']['temperature_2m_max']}max",
                style: const TextStyle(
                  color: Colors.orange,
                ),
              ),
              Text(
                "${widget.forecast?.forecastData['daily']['temperature_2m_min'][i]}${widget.forecast?.forecastData['daily_units']['temperature_2m_min']}min",
                style: const TextStyle(
                  color: Colors.blue,
                ),
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
                          'Weekly temperatures',
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
                              "${value.toInt().toString()}${widget.forecast?.forecastData['daily_units']['temperature_2m_max']}",
                            ),
                          ),
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          getTitlesWidget: (value, meta) {
                            DateTime date = DateTime.parse(widget.forecast
                                ?.forecastData['daily']['time'][value.toInt()]);
                            return SideTitleWidget(
                              axisSide: meta.axisSide,
                              fitInside: SideTitleFitInsideData.fromTitleMeta(
                                  meta,
                                  distanceFromEdge: 0),
                              child: value == value.toInt()
                                  ? Text('${date.month}/${date.day}')
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
                    gridData: const FlGridData(
                      verticalInterval: 1.0,
                    ),
                    minY: (minY - 1).round().toDouble(),
                    maxY: (maxY + 1).round().toDouble(),
                    minX: -0.3,
                    maxX: 6.3,
                    borderData: FlBorderData(),
                    lineBarsData: [
                      LineChartBarData(
                        spots: temperatureMax,
                        color: Colors.orange,
                      ),
                      LineChartBarData(
                        spots: temperatureMin,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Scrollbar(
                child: SingleChildScrollView(
                  primary: true,
                  scrollDirection: Axis.horizontal,
                  child: Row(children: dailyWidgets),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
