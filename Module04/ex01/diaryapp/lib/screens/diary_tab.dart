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

  @override
  void initState() {
    // エントリー一覧を読み込み
    db.readEntryList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('DiaryTab'),
    );
  }
}
