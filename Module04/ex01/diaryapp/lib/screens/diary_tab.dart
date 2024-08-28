import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../components/my_firestore.dart';

class DiaryTab extends StatefulWidget {
  final User user;

  const DiaryTab({
    super.key,
    required this.user,
  });

  @override
  DiaryTabState createState() => DiaryTabState();
}

class DiaryTabState extends State<DiaryTab> {
  final MyFirestore db = MyFirestore();

  Future<List<Map<String, dynamic>>> _getEntryList() async {
    return await db.readEntryList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _getEntryList(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          // 通信中はスピナーを表示
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          // エラー時はエラーメッセージを表示
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          // データが0個のとき
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Text("No entry.");
          }
          
          return Text(snapshot.data.toString());
        },
      ),
    );
  }
}
