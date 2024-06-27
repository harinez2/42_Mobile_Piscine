import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
    WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  void listenUserState() {
    // リスナーの登録直後。
    // ユーザーがログインしたとき。
    // 現在のユーザーがログアウトしたとき。
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('authStateChanges: User is currently signed out!');
      } else {
        print('authStateChanges: User is signed in!');
      }
    });

    // リスナーの登録直後。
    // ユーザーがログインしたとき。
    // 現在のユーザーがログアウトしたとき。
    // 現在のユーザーのトークンが変更されたとき。
    FirebaseAuth.instance.idTokenChanges().listen((User? user) {
      if (user == null) {
        print('idTokenChanges: User is currently signed out!');
      } else {
        print('idTokenChanges: User is signed in!');
      }
    });

    // リスナーの登録直後。
    // ユーザーがログインしたとき。
    // 現在のユーザーがログアウトしたとき。
    // 現在のユーザーのトークンが変更されたとき。
    // FirebaseAuth.instance.currentUser が提供する次のメソッドが呼び出されたとき:
    // reload()
    // unlink()
    // updateEmail()
    // updatePassword()
    // updatePhoneNumber()
    // updateProfile()
    FirebaseAuth.instance.userChanges().listen((User? user) {
      if (user == null) {
        print('userChanges: User is currently signed out!');
      } else {
        print('userChanges: User is signed in!');
      }
    });
  }

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
                onPressed: () {listenUserState();},
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
