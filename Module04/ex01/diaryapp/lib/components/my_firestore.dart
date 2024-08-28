import 'package:cloud_firestore/cloud_firestore.dart';

class MyFirestore {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> readEntryList() async {
    List<Map<String, dynamic>> ret = [];
    await db.collection("notes").get().then((event) {
      for (var doc in event.docs) {
        // print("${doc.id} => ${doc.data()}");
        Map<String, dynamic> element = doc.data();
        element.addAll({'docId': doc.id});
        ret.add(element);
      }
    });
    return ret;
  }
}
