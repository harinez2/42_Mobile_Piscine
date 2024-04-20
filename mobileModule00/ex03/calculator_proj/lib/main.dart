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
    double decimal = 0;
    bool isMinus = false;

    // 数式を配列に格納する
    int i = 0;
    while (i < formula.length) {
      if (operators.contains(formula[i])) {
        // オペレータの場合：
        // リセット
        decimal = 0;
        isMinus = false;
        // オペレータの順番が不正
        if (operatorList.length != numberList.length) {
          // オペレータが連続し、2個目が*/がある場合のみ不正
          if (formula[i] == 'x' || formula[i] == '/') {
            return 'Too much operators';
          } else if (formula[i] == '-') {
            isMinus = true;
          }
        } else {
          // 1つ目のオペレータの場合、リストに追加
          operatorList.add(formula[i]);
          currentIdx++;
        }
      } else if (numbers.contains(formula[i])) {
        // 数値の場合：
        // 数字の最初の1文字目の場合、リストに0を追加する
        if (numberList.length == currentIdx) {
          numberList.add(0);
        }
        if (formula[i] == '.') {
          decimal = 0.1;
        } else {
          if (decimal == 0) {
            // 整数部
            numberList[currentIdx] =
                numberList[currentIdx] * 10 + double.parse(formula[i]);
            if (isMinus) {
              numberList[currentIdx] *= -1;
              isMinus = false;
            }
          } else {
            // 小数部
            numberList[currentIdx] += double.parse(formula[i]) * decimal;
            decimal /= 10;
          }
        }
      }
      i++;
    }
    if (true) {
      // debug
      print(operatorList);
      print(numberList);
    }
    if (i != formula.length || operatorList.length != numberList.length) {
      //数式不正
      return 'Invalid formula';
    }

    // 計算する
    while (1 < numberList.length) {
      // x/を検索
      var pos = -1;
      try {
        pos = operatorList.indexOf(operatorList
            .firstWhere((element) => (element == 'x' || element == '/')));
      } catch (e) {
        // x/が見つからない場合は例外を無視
      }
      // x/が見つかった場合、計算する
      if (pos != -1) {
        try {
          if (operatorList[pos] == 'x') {
            numberList[pos - 1] *= numberList[pos];
          } else {
            numberList[pos - 1] /= numberList[pos];
          }
          operatorList.removeAt(pos);
          numberList.removeAt(pos);
        } catch (e) {
          // 計算に問題があった場合は、エラーをそのまま画面に出す
          return e;
        }
        continue;
      }

      // +-を検索
      try {
        pos = operatorList.indexOf(operatorList
            .firstWhere((element) => (element == '+' || element == '-')));
      } catch (e) {
        // +-が見つからない場合は例外を無視
      }
      // x/が見つかった場合、計算する
      if (pos != -1) {
        try {
          if (operatorList[pos] == '+') {
            numberList[pos - 1] += numberList[pos];
          } else {
            numberList[pos - 1] -= numberList[pos];
          }
          operatorList.removeAt(pos);
          numberList.removeAt(pos);
        } catch (e) {
          // 計算に問題があった場合は、エラーをそのまま画面に出す
          return e;
        }
      }
    }
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
