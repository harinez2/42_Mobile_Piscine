
import 'package:flutter/material.dart';
import '../components/my_firestore.dart';

class DiaryInputDialog extends StatelessWidget {
  final MyFirestore db;

  const DiaryInputDialog({
    super.key,
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
