import 'dart:html';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainAppState extends ChangeNotifier {
  final numbers = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '00', '.'];
  final operators = ['+', '-', 'x', '/'];
  var formula = '0';
  var answer = '0';

  void setValue(String op) {
    if (op == 'AC') {
      // AC
      formula = '0';
      answer = '0';
    } else if (op == 'C') {
      // C
      if (formula.isNotEmpty) {
        formula = formula.substring(0, formula.length - 1);
      }
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
      answer = Calculate.calc(formula).toString();
    }
    notifyListeners();
  }
}

class Calculate {
  static dynamic calc(String formula) {
    final numbers = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '.'];
    final operators = ['+', '-', 'x', '/'];
    List<String> operatorList = [' '];
    List<double> numberList = [];
    int currentIdx = 0;
    double multiply = 10;

    // 数式を配列に格納する
    int i = 0;
    while (i < formula.length) {
      if (operators.contains(formula[i])) {
        // オペレータの場合：
        // リセット
        multiply = 10;
        currentIdx++;
        // 先頭に*/があるのは不正
        if (i == 0 && (formula[i] == '*' || formula[i] == '/')) {
          break;
        }
        // オペレータが連続し、2個目が*/がある場合は不正
        if (operatorList.length == currentIdx + 1 &&
            (formula[i] == '*' || formula[i] == '/')) {
          break;
        }
        operatorList.add(formula[i]);
      } else if (numbers.contains(formula[i])) {
        // 数値の場合：
        // 数字の最初の位置文字目の場合、リストに0を追加する
        if (numberList.length == currentIdx) {
          numberList.add(0);
        }
        if (formula[i] == '.') {
          multiply = 0.1;
        } else {
          numberList[currentIdx] =
              numberList[currentIdx] * multiply + double.parse(formula[i]);
        }
        operators.add('+');
      }
      i++;
    }
    if (i != formula.length || operatorList.length != numberList.length) {
      //数式不正
      return 'Invalid formula';
    }
    if (true) {
      // debug
      print(operatorList);
      print(numberList);
    }

    // 計算する
    // double leftNum = 0;
    // double rightNum = 0;
    // var operator = '';
    // var i = 0;
    // while (i < formula.length) {
    //   if (numbers.contains(formula[i])) {
    //     if (formula[i] == '.') {
    //       multiply = 0.1;
    //     } else {
    //       rightNum = rightNum * multiply + double.parse(formula[i]);

    //       // if the end of a number
    //       if (i + 1 < formula.length && operator.contains(formula[i + 1]) ||
    //           i + 1 == formula.length) {
    //         if (operator == '+') {
    //           leftNum += rightNum;
    //         } else if (operator == '-') {
    //           leftNum -= rightNum;
    //         } else if (operator == 'x') {
    //           leftNum *= rightNum;
    //         } else if (operator == '/') {
    //           leftNum /= rightNum;
    //         }
    //         rightNum = 0;
    //         operator = '';
    //         multiply = 10;
    //       }
    //     }
    //   } else if (operators.contains(formula[i]) &&
    //       (i + 1 < formula.length && !operators.contains(formula[i + 1]))) {
    //     operator = formula[i];
    //   }
    //   i++;
    // }
    return numberList[0];
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
