import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainAppState extends ChangeNotifier {
  final numbers = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '00', '.'];
  final operators = ['+', '-', 'x', '/',];
  var formula = '0';
  var answer = '0';

  void setValue(String op) {
    if (op == 'AC') {
      // AC
      formula = '0';
      answer = '0';
    } else if (op == 'C') {
      // C
      formula = formula.substring(0, formula.length - 1);
      if (formula.isEmpty) {
        formula = '0';
      }
    } else if (numbers.contains(op)) {
      // numbers
      if (formula != '0') {
        formula += op;
      } else if (op != '0' && op != '00') {
        formula = op;
      }
    } else if (operators.contains(op)) {
      // operators
      // if (operators.contains(formula[formula.length - 1])) {
      //   formula = formula.substring(0, formula.length - 1) + op;
      // } else {
        formula += op;
      // }
    } else if (op == '=') {
      // =
      answer = Calculate.calc(formula);
    }
    notifyListeners();
  }
}

class Calculate {
  static String calc(dynamic formula) {
    return '1';
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
