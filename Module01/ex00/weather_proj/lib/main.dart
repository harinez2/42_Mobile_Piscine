import 'package:flutter/material.dart';
import 'screens/currently.dart';
import 'screens/today.dart';
import 'screens/weekly.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    CurrentlyTab(),
    TodayTab(),
    WeeklyTab(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          // 左側のアイコン
          leading: const Icon(Icons.search),
          // タイトルテキスト
          title: TextField(
            textAlign: TextAlign.left,
            controller: TextEditingController(text: 'Search location...'),
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
          ),
          // 右側のアイコン一覧
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.assistant_navigation),
            ),
          ],
        ),
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: _onItemTapped,
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          destinations: const <NavigationDestination>[
            NavigationDestination(icon: Icon(Icons.home), label: 'Currently'),
            NavigationDestination(icon: Icon(Icons.home), label: 'Today'),
            NavigationDestination(icon: Icon(Icons.home), label: 'Weekly'),
          ],
        ),
      ),
    );
  }
}
