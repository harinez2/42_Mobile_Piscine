import 'package:cloud_firestore/cloud_firestore.dart';

class MyFirestore {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  void readEntryList() {
    db.collection("notes").get().then((event) {
      for (var doc in event.docs) {
        print("${doc.id} => ${doc.data()}");
      }
    });
  }
}
