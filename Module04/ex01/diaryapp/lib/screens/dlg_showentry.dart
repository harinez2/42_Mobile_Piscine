
import 'package:flutter/material.dart';
import '../components/my_firestore.dart';

class ShowEntryDialog extends StatelessWidget {
  final MyFirestore db;
  final Map<String, dynamic> entry;

  const ShowEntryDialog({
    super.key,
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
