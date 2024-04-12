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
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: TextButton(
                            onPressed: () {}, child: const Text('7'))),
                    Expanded(
                        child: TextButton(
                            onPressed: () {}, child: const Text('8'))),
                    Expanded(
                        child: TextButton(
                            onPressed: () {}, child: const Text('9'))),
                    Expanded(
                        child: TextButton(
                            onPressed: () {}, child: const Text('C'))),
                    Expanded(
                        child: TextButton(
                            onPressed: () {}, child: const Text('AC'))),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: TextButton(
                            onPressed: () {}, child: const Text('4'))),
                    Expanded(
                        child: TextButton(
                            onPressed: () {}, child: const Text('5'))),
                    Expanded(
                        child: TextButton(
                            onPressed: () {}, child: const Text('6'))),
                    Expanded(
                        child: TextButton(
                            onPressed: () {}, child: const Text('+'))),
                    Expanded(
                        child: TextButton(
                            onPressed: () {}, child: const Text('-'))),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: TextButton(
                            onPressed: () {}, child: const Text('1'))),
                    Expanded(
                        child: TextButton(
                            onPressed: () {}, child: const Text('2'))),
                    Expanded(
                        child: TextButton(
                            onPressed: () {}, child: const Text('3'))),
                    Expanded(
                        child: TextButton(
                            onPressed: () {}, child: const Text('x'))),
                    Expanded(
                        child: TextButton(
                            onPressed: () {}, child: const Text('/'))),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: TextButton(
                            onPressed: () {}, child: const Text('0'))),
                    Expanded(
                        child: TextButton(
                            onPressed: () {}, child: const Text('.'))),
                    Expanded(
                        child: TextButton(
                            onPressed: () {}, child: const Text('00'))),
                    Expanded(
                        child: TextButton(
                            onPressed: () {}, child: const Text('='))),
                    Expanded(
                        child: TextButton(
                            onPressed: () {}, child: const Text(' '))),
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
