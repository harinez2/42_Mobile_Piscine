import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
      title: TextField(
        controller: ctrlrTitle,
        readOnly: true,
        decoration: const InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                DateFormat("yyyy/MM/dd hh:mm:ss")
                    .format(entry['date'].toDate())
                    .toString(),
              ),
            ],
          ),
          const SizedBox(height: 20, width: 400),
          Row(children: [
            const Text('My feeling: '),
            Icon(IconData(entry['icon'], fontFamily: 'MaterialIcons')),
          ]),
          const SizedBox(height: 20),
          TextField(
            controller: ctrlrText,
            decoration: InputDecoration(
              fillColor: Colors.purple[100],
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
            ),
            keyboardType: TextInputType.multiline,
            maxLines: null,
            minLines: 6,
            readOnly: true,
          ),
          const SizedBox(height: 20),
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
