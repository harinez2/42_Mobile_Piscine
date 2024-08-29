import 'package:cloud_firestore/cloud_firestore.dart';
import 'app_constants.dart';

class MyFirestore {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  // エントリー一覧を取得
  Future<List<Map<String, dynamic>>> readEntryList() async {
    List<Map<String, dynamic>> ret = [];
    await db
        .collection(AppConstants.firebaseCollectionName)
        .get()
        .then((event) {
      for (var doc in event.docs) {
        // print("${doc.id} => ${doc.data()}");
        Map<String, dynamic> element = doc.data();
        element.addAll({'docId': doc.id});
        ret.add(element);
      }
    });
    return ret;
  }

  // 新エントリーを追加
  Future<String?> postNewEntry(Map<String, dynamic> newEntry) async {
    String? ret;
    await db
        .collection(AppConstants.firebaseCollectionName)
        .add(newEntry)
        .then((DocumentReference doc) {
      ret = doc.id;
      print('New entry added with ID: ${doc.id}');
    });

    return ret;
  }
}
