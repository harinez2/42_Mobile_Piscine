import 'package:firebase_auth/firebase_auth.dart';
import 'my_google_signin.dart';

class MyFirebaseAuth {
  // リスナーの登録直後。
  // ユーザーがログインしたとき。
  // 現在のユーザーがログアウトしたとき。
  static void listenAuthStateChanges() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user == null) {
        print('authStateChanges: User is currently signed out!');

        // 認証
        // final userCredential = await MyGoogleSignIn.signInWithGoogleIosAndroid();
        final userCredential = await MyGoogleSignIn.signInWithGoogleWeb();
        final user = userCredential.user;
        print('Sigened in: ${user?.uid}');
      } else {
        print('authStateChanges: User is signed in! (user: ${user.uid})');
      }
    });
  }

  // リスナーの登録直後。
  // ユーザーがログインしたとき。
  // 現在のユーザーがログアウトしたとき。
  // 現在のユーザーのトークンが変更されたとき。
  static void listenIdTokenChanges() {
    FirebaseAuth.instance.idTokenChanges().listen((User? user) {
      if (user == null) {
        print('idTokenChanges: User is currently signed out!');
      } else {
        print('idTokenChanges: User is signed in! (user: ${user.uid})');
      }
    });
  }

  // リスナーの登録直後
  // ユーザーがログインしたとき
  // 現在のユーザーがログアウトしたとき
  // 現在のユーザーのトークンが変更されたとき
  // FirebaseAuth.instance.currentUser が提供する特定のメソッドが呼び出されたとき
  // に本メソッドが呼び出される
  static void listenUserChanges() {
    FirebaseAuth.instance.userChanges().listen((User? user) async {
      if (user == null) {
        print('userChanges: User is currently signed out!');

        // 認証
        // final userCredential = await MyGoogleSignIn.signInWithGoogleIosAndroid();
        final userCredential = await MyGoogleSignIn.signInWithGoogleWeb();
        final user = userCredential.user;
        print('Sigened in: ${user?.uid}');
      } else {
        print('userChanges: User is signed in! (user: ${user.uid})');
      }
    });
  }
}
