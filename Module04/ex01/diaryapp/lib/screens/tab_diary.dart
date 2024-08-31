import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('DiaryTab ${widget.user.uid}'),
    );
  }
}