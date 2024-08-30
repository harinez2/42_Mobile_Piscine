import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileTab extends StatefulWidget {
  final User user;

  const ProfileTab({
    super.key,
    required this.user,
  });

  @override
  ProfileTabState createState() => ProfileTabState();
}

class ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('ProfileTab ${widget.user.uid}'),
    );
  }
}
