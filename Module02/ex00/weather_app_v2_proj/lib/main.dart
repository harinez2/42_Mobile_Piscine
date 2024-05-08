import 'package:flutter/material.dart';
import 'screens/currently.dart';
import 'screens/today.dart';
import 'screens/weekly.dart';
import 'package:geolocator/geolocator.dart';

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
  late TextEditingController _textEditingController;
  final PageController _pageController = PageController(initialPage: 0);

  late List<Widget> _widgetOptions = <Widget>[
    const CurrentlyTab(),
    const TodayTab(),
    const WeeklyTab(),
  ];

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  void _onChangeText({String displayText = '', String? errorText}) {
    _widgetOptions = <Widget>[
      CurrentlyTab(
        displayText: displayText,
        errorText: errorText,
      ),
      TodayTab(
        displayText: displayText,
        errorText: errorText,
      ),
      WeeklyTab(
        displayText: displayText,
        errorText: errorText,
      ),
    ];
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
          // 左側のアイコン
          leading: const Icon(Icons.search),
          // タイトルテキスト
          title: TextField(
            textAlign: TextAlign.left,
            controller: _textEditingController,
            onChanged: (text) {
              setState(() {
                _onChangeText(displayText: text);
              });
            },
            decoration: const InputDecoration(
              border: InputBorder.none,
              labelText: 'Search location...',
            ),
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
                  Position position = await _determinePosition();
                  setState(() {
                    _onChangeText(displayText: '''
position.longitude: ${position.longitude}
position.latitude: ${position.latitude}
position.timestamp: ${position.timestamp}
position.accuracy: ${position.accuracy}
position.altitude: ${position.altitude}
position.altitudeAccuracy: ${position.altitudeAccuracy}
position.heading: ${position.heading}
position.headingAccuracy: ${position.headingAccuracy}
position.speed: ${position.speed}
position.speedAccuracy: ${position.speedAccuracy}
position.floor: ${position.floor}
position.isMocked: ${position.isMocked}
                    ''');
                  });
                } catch (error) {
                  setState(() {
                    _onChangeText(errorText: error.toString());
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

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
}
