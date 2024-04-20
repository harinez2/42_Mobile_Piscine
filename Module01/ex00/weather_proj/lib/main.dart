import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

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
        body: const Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
