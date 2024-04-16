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
      theme: ThemeData.from(
        colorScheme: ColorScheme.light(
          primary: Colors.blueGrey,
          background: Colors.blueGrey.shade800,
        ),
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.blueGrey),
        ),
      ),
      // theme: ThemeData(
      //   appBarTheme: const AppBarTheme(backgroundColor: Colors.blue),
      // ),
      home: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Calculator')),
        ),
        body: const HomeScreen(),
      ),
    );
  }
}
