import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  Future<UserCredential> signInWithGoogleIosAndroid() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential> signInWithGoogleWeb() async {
    // Create a new provider
    GoogleAuthProvider googleProvider = GoogleAuthProvider();

    googleProvider.addScope('https://www.googleapis.com/auth/contacts.readonly');
    // googleProvider.setCustomParameters({
    //   'login_hint': 'user@example.com'
    // });

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithPopup(googleProvider);

    // Or use signInWithRedirect
    // return await FirebaseAuth.instance.signInWithRedirect(googleProvider);
  }

  void listenUserState() {
    // リスナーの登録直後。
    // ユーザーがログインしたとき。
    // 現在のユーザーがログアウトしたとき。
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user == null) {
        print('authStateChanges: User is currently signed out!');

        // 認証
        // final userCredential = await signInWithGoogleIosAndroid();
        final userCredential = await signInWithGoogleWeb();
        final user = userCredential.user;
        print('Sigened in: ${user?.uid}');
      } else {
        print('authStateChanges: User is signed in! (user: ${user.uid})');
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
        print('idTokenChanges: User is signed in! (user: ${user.uid})');
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
        print('userChanges: User is signed in! (user: ${user.uid})');
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
                onPressed: () {
                  listenUserState();
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
