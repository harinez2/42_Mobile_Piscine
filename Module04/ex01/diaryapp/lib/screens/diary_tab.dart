import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
                              return _DiaryShowContentsDialog(
                                db: db,
                                entry: cardData,
                              );
                            },
                          );
                          if (isRequiredRefresh == true) setState(() {});
                        },
                      ),
                    ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                final bool? isRequiredRefresh = await showDialog(
                  context: context,
                  builder: (context) {
                    return _DiaryInputDialog(db: db);
                  },
                );
                if (isRequiredRefresh == true) setState(() {});
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
  final MyFirestore db;

  const _DiaryInputDialog({
    required this.db,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController ctrlrTitle = TextEditingController();
    TextEditingController ctrlrText = TextEditingController();
    final List<Widget> actions = [
      TextButton(
        child: const Text('Cancel'),
        onPressed: () => Navigator.pop(context, false),
      ),
      ElevatedButton(
        child: const Text('Add'),
        onPressed: () async {
          await db.postNewEntry({
            'date': DateTime.now(),
            'icon': 58750,
            'text': ctrlrText.text,
            'title': ctrlrTitle.text,
            'usermail': 'user@example.com',
          });
          Navigator.pop(context, true);
        },
      ),
    ];

    return AlertDialog(
      title: const Text("Add an entry"),
      content: Column(
        children: [
          SizedBox(
            width: 400,
            child: TextField(
              controller: ctrlrTitle,
              decoration: const InputDecoration(
                labelText: 'Title',
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(),
              ),
              autofocus: true,
              keyboardType: TextInputType.text,
            ),
          ),
          const SizedBox(height: 4),
          TextField(
            controller: ctrlrText,
            decoration: const InputDecoration(
              labelText: 'Text',
              enabledBorder: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(),
            ),
            autofocus: true,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            minLines: 6,
          ),
        ],
      ),
      actions: actions,
    );
  }
}

class _DiaryShowContentsDialog extends StatelessWidget {
  final MyFirestore db;
  final Map<String, dynamic> entry;

  const _DiaryShowContentsDialog({
    required this.db,
    required this.entry,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController ctrlrTitle = TextEditingController();
    ctrlrTitle.text = entry['title'];
    TextEditingController ctrlrText = TextEditingController();
    ctrlrText.text = entry['text'];
    final List<Widget> actions = [
      TextButton(
        child: const Text('Close'),
        onPressed: () => Navigator.pop(context),
      ),
    ];

    return AlertDialog(
      title: const Text("Entry"),
      content: Column(
        children: [
          SizedBox(
            width: 400,
            child: TextField(
              controller: ctrlrTitle,
              decoration: const InputDecoration(
                labelText: 'Title',
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(),
              ),
              autofocus: true,
              keyboardType: TextInputType.text,
            ),
          ),
          const SizedBox(height: 4),
          TextField(
            controller: ctrlrText,
            decoration: const InputDecoration(
              labelText: 'Text',
              enabledBorder: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(),
            ),
            autofocus: true,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            minLines: 6,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: const Text(
                            'Are you sure you want to delete this entry?'),
                        actions: [
                          TextButton(
                              child: const Text('Yes'),
                              onPressed: () async {
                                await db.deleteEntry(entry['docId']);
                                Navigator.pop(context);
                                Navigator.pop(context, true);
                              }),
                          TextButton(
                            child: const Text('No'),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Text('Delete this entry'),
              ),
            ],
          )
        ],
      ),
      actions: actions,
    );
  }
}
