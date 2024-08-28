import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import '../components/my_firestore.dart';

class DiaryTab extends StatefulWidget {
  final User user;

  const DiaryTab({
    super.key,
    required this.user,
  });

  @override
  DiaryTabState createState() => DiaryTabState();
}

class DiaryTabState extends State<DiaryTab> {
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

          return Scaffold(
            body: Column(
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
                    ),
                  ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => {
                showDialog(
                  context: context,
                  builder: (context) {
                    return _DiaryInputDialog();
                  },
                )
              },
              child: const Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }
}

class _DiaryInputDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Widget> actions = [
      TextButton(
        child: const Text('Cancel'),
        onPressed: () => Navigator.pop(context),
      ),
      ElevatedButton(
        child: const Text('Add'),
        onPressed: () => Navigator.pop(context),
      ),
    ];

    return AlertDialog(
      title: const Text("Add content"),
      content: Container(
        width: double.infinity,
        child: Column(
          children: [
            TextField(
              controller: TextEditingController(),
              decoration: InputDecoration(
                labelText: 'title',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              autofocus: true,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 4),
            TextField(
              controller: TextEditingController(),
              decoration: InputDecoration(
                labelText: 'body',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              autofocus: true,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              minLines: 6,
            ),
          ],
        ),
      ),
      actions: actions,
    );
  }
}
