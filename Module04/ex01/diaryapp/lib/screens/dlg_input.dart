import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/my_firestore.dart';

class InputDialog extends StatefulWidget {
  final MyFirestore db;
  final User user;

  const InputDialog({
    super.key,
    required this.db,
    required this.user,
  });

  @override
  InputDialogState createState() => InputDialogState();
}

class InputDialogState extends State<InputDialog> {
  String _choiceIndex = '';

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
          await widget.db.postNewEntry({
            'date': DateTime.now(),
            'icon': 58750,
            'text': ctrlrText.text,
            'title': ctrlrTitle.text,
            'usermail': widget.user.email,
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
          Row(
            children: [
              ChoiceChip(
                label: const Icon(
                  Icons.sentiment_very_satisfied,
                ),
                selected: _choiceIndex == Icons.sentiment_very_satisfied.toString(),
                onSelected: (_) {
                  setState(() {
                    _choiceIndex = Icons.sentiment_very_satisfied.toString();
                  });
                },
              ),
              ChoiceChip(
                label: const Icon(
                  Icons.sentiment_satisfied_alt,
                ),
                selected: _choiceIndex == Icons.sentiment_satisfied_alt.toString(),
                onSelected: (_) {
                  setState(() {
                    _choiceIndex = Icons.sentiment_satisfied_alt.toString();
                  });
                },
              ),
              ChoiceChip(
                label: const Icon(
                  Icons.sentiment_neutral,
                ),
                selected: _choiceIndex == Icons.sentiment_neutral.toString(),
                onSelected: (_) {
                  setState(() {
                    _choiceIndex = Icons.sentiment_neutral.toString();
                  });
                },
              ),
              ChoiceChip(
                label: const Icon(
                  Icons.sentiment_dissatisfied,
                ),
                selected: _choiceIndex == Icons.sentiment_dissatisfied.toString(),
                onSelected: (_) {
                  setState(() {
                    _choiceIndex = Icons.sentiment_dissatisfied.toString();
                  });
                },
              ),
              ChoiceChip(
                label: const Icon(
                  Icons.sentiment_very_dissatisfied,
                ),
                selected: _choiceIndex == Icons.sentiment_very_dissatisfied.toString(),
                onSelected: (_) {
                  setState(() {
                    _choiceIndex = Icons.sentiment_very_dissatisfied.toString();
                  });
                },
              ),
            ],
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
