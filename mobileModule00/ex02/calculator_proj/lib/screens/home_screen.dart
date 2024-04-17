import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                TextField(
                  textAlign: TextAlign.right,
                  controller: TextEditingController(text: '0'),
                ),
                TextField(
                  textAlign: TextAlign.right,
                  controller: TextEditingController(text: '0'),
                ),
              ],
            ),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              children: [
                Row(
                  children: [
                    CalcButton(buttonName: '7'),
                    CalcButton(buttonName: '8'),
                    CalcButton(buttonName: '9'),
                    CalcButton(
                        buttonName: 'C',
                        textStyle: TextStyle(
                          color: Colors.red,
                        )),
                    CalcButton(
                        buttonName: 'AC',
                        textStyle: TextStyle(
                          color: Colors.red,
                        )),
                  ],
                ),
                Row(
                  children: [
                    CalcButton(buttonName: '4'),
                    CalcButton(buttonName: '5'),
                    CalcButton(buttonName: '6'),
                    CalcButton(
                        buttonName: '+',
                        textStyle: TextStyle(
                          color: Colors.white,
                        )),
                    CalcButton(
                        buttonName: '-',
                        textStyle: TextStyle(
                          color: Colors.white,
                        )),
                  ],
                ),
                Row(
                  children: [
                    CalcButton(buttonName: '1'),
                    CalcButton(buttonName: '2'),
                    CalcButton(buttonName: '3'),
                    CalcButton(
                        buttonName: 'x',
                        textStyle: TextStyle(
                          color: Colors.white,
                        )),
                    CalcButton(
                        buttonName: '/',
                        textStyle: TextStyle(
                          color: Colors.white,
                        )),
                  ],
                ),
                Row(
                  children: [
                    CalcButton(buttonName: '0'),
                    CalcButton(buttonName: '.'),
                    CalcButton(buttonName: '00'),
                    CalcButton(
                        buttonName: '=',
                        textStyle: TextStyle(
                          color: Colors.white,
                        )),
                    CalcButton(buttonName: ' '),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CalcButton extends StatelessWidget {
  final String buttonName;
  final TextStyle textStyle;

  const CalcButton({
    super.key,
    required this.buttonName,
    this.textStyle = const TextStyle(),
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton(
        onPressed: () {
          print('Button pressed: $buttonName');
        },
        style: TextButton.styleFrom(
          backgroundColor: Colors.blueGrey,
          foregroundColor: Colors.black,
          shape: const BeveledRectangleBorder(),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            buttonName,
            style: textStyle,
          ),
        ),
      ),
    );
  }
}
