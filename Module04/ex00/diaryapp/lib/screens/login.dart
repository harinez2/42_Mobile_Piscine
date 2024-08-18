import 'package:flutter/material.dart';
import '../components/my_google_signin.dart';

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
                  // 認証
                  MyGoogleSignIn.signInWithGoogleWeb();
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
