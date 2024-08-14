import 'package:flutter/material.dart';
import '../components/my_firebase_auth.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Welcome to your diary'),
              const SizedBox(height: 30.0),
              ElevatedButton(
                onPressed: () {
                  MyFirebaseAuth.listenUserChanges();
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
