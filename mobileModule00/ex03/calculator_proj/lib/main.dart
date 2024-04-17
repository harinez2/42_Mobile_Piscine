import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainAppState extends ChangeNotifier {
  var formula = '0';
  var answer = '0';

  void setValue(String op) {
    if (op == 'AC' || op == 'C') {
      // C, AC
      formula = '0';
      answer = '0';
    } else {
      // numbers, operators
      if (formula == '0') {
        formula = '';
      }
      formula += op;
    }

    notifyListeners();
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MainAppState(),
      child: MaterialApp(
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
      ),
    );
  }
}
