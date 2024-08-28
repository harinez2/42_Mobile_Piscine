import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'screens/home.dart';
import 'screens/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  MainAppState createState() => MainAppState();
}

class MainAppState extends State<MainApp> {
  User? currentUser;

  @override
  void initState() {
    super.initState();

    currentUser = FirebaseAuth.instance.currentUser;
    // 認証ステータスのリスナーを設定
    listenUserChanges();
  }

  void listenUserChanges() {
    FirebaseAuth.instance.userChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in! (user: ${user.uid})');
      }
      setState(() {
        currentUser = FirebaseAuth.instance.currentUser;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (currentUser != null) {
      return HomePage(user: currentUser!);
    } else {
      return LoginPage();
    }
  }
}
