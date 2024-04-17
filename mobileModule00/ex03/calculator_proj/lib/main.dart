import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: Colors.blueGrey,
          background: Colors.blueGrey.shade800,
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.blueGrey),
        ),
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.blueGrey,
            titleTextStyle: TextStyle(color: Colors.white)),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Calculator')),
        ),
        body: const HomeScreen(),
      ),
    );
  }
}
