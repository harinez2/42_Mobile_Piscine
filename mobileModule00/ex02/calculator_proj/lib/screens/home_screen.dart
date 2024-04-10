import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
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
    );
  }
}
