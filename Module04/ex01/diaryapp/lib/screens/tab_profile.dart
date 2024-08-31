import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import '../components/my_firestore.dart';
import 'dlg_input.dart';
import 'dlg_showentry.dart';

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
  final MyFirestore db = MyFirestore();

  Future<List<Map<String, dynamic>>> _getEntryList() async {
    return await db.readEntryList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _getEntryList(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          // 通信中はスピナーを表示
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          // エラー時はエラーメッセージを表示
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          // データがない/0個のとき
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Text("No entry.");
          }

          // 日付順にソート
          snapshot.data!
              .sort((a, b) => b['date'].toDate().compareTo(a['date'].toDate()));

          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  for (final cardData in snapshot.data!)
                    Card(
                      child: ListTile(
                        // leading: Image.network('https://placehold.jp/50x50.png'),
                        title: Text(cardData['title']),
                        subtitle: Text(
                          DateFormat("yyyy/MM/dd hh:mm:ss")
                              .format(cardData['date'].toDate())
                              .toString(),
                          style: const TextStyle(
                              fontSize: 16.0, color: Colors.black),
                        ),
                        trailing: Icon(IconData(cardData['icon'],
                            fontFamily: 'MaterialIcons')),
                        onTap: () async {
                          final bool? isRequiredRefresh = await showDialog(
                            context: context,
                            builder: (context) {
                              return ShowEntryDialog(
                                db: db,
                                entry: cardData,
                              );
                            },
                          );
                          if (isRequiredRefresh == true) setState(() {});
                        },
                      ),
                    ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple[700],
                      foregroundColor: Colors.purple[50],
                    ),
                    child: const Text('Add entry'),
                    onPressed: () async {
                      final bool? isRequiredRefresh = await showDialog(
                        context: context,
                        builder: (context) {
                          return InputDialog(db: db, user: widget.user);
                        },
                      );
                      if (isRequiredRefresh == true) setState(() {});
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
