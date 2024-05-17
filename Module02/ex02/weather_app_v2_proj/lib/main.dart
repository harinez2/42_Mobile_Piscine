import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'screens/currently.dart';
import 'screens/today.dart';
import 'screens/weekly.dart';
import 'components/geolocator.dart';
import 'components/geocoding_api.dart';
import 'components/geocoding_api_google.dart';
import 'components/weather_forecast_api.dart';
import 'components/debounce.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  MainAppState createState() => MainAppState();
}

class MainAppState extends State<MainApp> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);
  String? _currentQuery;
  Iterable<Map<String, dynamic>> _lastOptions = <Map<String, dynamic>>[];
  late final Debounceable<GeoCoding, String> _debounceFetchGeoCoding;
  bool _networkError = false;

  late List<Widget> _widgetOptions = <Widget>[
    const CurrentlyTab(),
    const TodayTab(),
    const WeeklyTab(),
  ];

  @override
  void initState() {
    super.initState();
    _debounceFetchGeoCoding = debounce<GeoCoding, String>(fetchGeoCoding);
  }

  Future<WeatherForecast?> getForecast(
      double? latitude, double? longtitude) async {
    try {
      if (latitude != null && longtitude != null) {
        return await fetchForecastCurrent(latitude, longtitude);
      } else {
        return null;
      }
    } catch (error) {
      return null;
    }
  }

  void _onSelected({dynamic geoData = const {}, String? errorText}) async {
    WeatherForecast? forecast;
    if (geoData != {}) {
      forecast = await getForecast(geoData['latitude'], geoData['longitude']);
    }
    setState(() {
      _widgetOptions = <Widget>[
        CurrentlyTab(
          geoData: geoData,
          forecast: forecast,
          errorText: errorText,
        ),
        TodayTab(
          geoData: geoData,
          forecast: forecast,
          errorText: errorText,
        ),
        WeeklyTab(
          geoData: geoData,
          forecast: forecast,
          errorText: errorText,
        ),
      ];
    });
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(_selectedIndex,
          duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
    });
  }

  void _onDestinationSelected(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(_selectedIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          toolbarHeight: 80.0,
          // 左側のアイコン
          leading: const Icon(Icons.search),
          // タイトルテキスト
          title: Autocomplete<Map<String, dynamic>>(
            displayStringForOption: (e) =>
                "${e['name']}, ${e['admin1']}, ${e['country']}",
            fieldViewBuilder:
                (context, textEditingController, focusNode, onFieldSubmitted) {
              return TextField(
                controller: textEditingController,
                focusNode: focusNode,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Search location...',
                  errorText: _networkError
                      ? 'Network error, please check the network connection.'
                      : null,
                ),
              );
            },
            optionsBuilder: (TextEditingValue textEditingValue) async {
              setState(() {
                _networkError = false;
              });
              if (textEditingValue.text.length < 3) {
                return const Iterable.empty();
              } else {
                _currentQuery = textEditingValue.text;
                GeoCoding? ret;
                try {
                  ret = await _debounceFetchGeoCoding(textEditingValue.text);
                } catch (error) {
                  setState(() {
                    _networkError = true;
                  });
                }
                if (_currentQuery != textEditingValue.text) {
                  return _lastOptions;
                }
                if (ret != null) {
                  _lastOptions = ret.geoData;
                }
                return _lastOptions;
              }
            },
            onSelected: (dynamic selected) {
              setState(() {
                _onSelected(geoData: selected);
              });
            },
          ),
          // 右側のアイコン一覧
          actions: <Widget>[
            VerticalDivider(
              color: Colors.blueGrey.shade300,
              thickness: 2,
              indent: 10,
              endIndent: 10,
            ),
            IconButton(
              onPressed: () async {
                try {
                  Position position = await GeoLocator.determinePosition();
                  ReverseGeoCoding revGeo = await fetchReverseGeoCoding(
                      position.latitude.toString(),
                      position.longitude.toString());
                  Map<String, dynamic> newGeoData = GeoLocator.toMap(position);
                  final int separateCountryPos =
                      revGeo.geoData['compound_code'].lastIndexOf(' ');
                  newGeoData['name'] = revGeo.geoData['compound_code']
                      .substring(
                          revGeo.geoData['compound_code'].indexOf(' ') + 1,
                          separateCountryPos - 1);
                  newGeoData['country'] = revGeo.geoData['compound_code']
                      .substring(separateCountryPos + 1);
                  setState(() {
                    _onSelected(geoData: newGeoData);
                  });
                } catch (error) {
                  setState(() {
                    _onSelected(errorText: error.toString());
                  });
                }
              },
              icon: const Icon(Icons.assistant_navigation),
            ),
          ],
        ),
        body: PageView(
          controller: _pageController,
          onPageChanged: _onPageChanged,
          children: _widgetOptions,
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: _onDestinationSelected,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          destinations: const <NavigationDestination>[
            NavigationDestination(
                icon: Icon(Icons.settings), label: 'Currently'),
            NavigationDestination(icon: Icon(Icons.event), label: 'Today'),
            NavigationDestination(
                icon: Icon(Icons.date_range), label: 'Weekly'),
          ],
        ),
      ),
    );
  }
}
