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
        builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data.toString());
          } else {
            return const Text("No entry.");
          }
        },
      ),
    );
  }
}
