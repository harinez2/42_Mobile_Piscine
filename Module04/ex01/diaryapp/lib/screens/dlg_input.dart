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
  TextEditingController ctrlrTitle = TextEditingController();
  TextEditingController ctrlrText = TextEditingController();
  IconData _choicedIcon = Icons.sentiment_neutral;

  @override
  Widget build(BuildContext context) {
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
            'icon': _choicedIcon.codePoint,
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
              onChanged: (value) => ctrlrTitle.text = value,
            ),
          ),
          const SizedBox(height: 4),
          Wrap(
            children: [
              ChoiceChip(
                label: const Icon(
                  Icons.sentiment_very_satisfied,
                ),
                showCheckmark: false,
                selected: _choicedIcon == Icons.sentiment_very_satisfied,
                onSelected: (_) {
                  setState(() {
                    _choicedIcon = Icons.sentiment_very_satisfied;
                  });
                },
              ),
              ChoiceChip(
                label: const Icon(
                  Icons.sentiment_satisfied_alt,
                ),
                showCheckmark: false,
                selected: _choicedIcon == Icons.sentiment_satisfied_alt,
                onSelected: (_) {
                  setState(() {
                    _choicedIcon = Icons.sentiment_satisfied_alt;
                  });
                },
              ),
              ChoiceChip(
                label: const Icon(
                  Icons.sentiment_neutral,
                ),
                showCheckmark: false,
                selected: _choicedIcon == Icons.sentiment_neutral,
                onSelected: (_) {
                  setState(() {
                    _choicedIcon = Icons.sentiment_neutral;
                  });
                },
              ),
              ChoiceChip(
                label: const Icon(
                  Icons.sentiment_dissatisfied,
                ),
                showCheckmark: false,
                selected: _choicedIcon == Icons.sentiment_dissatisfied,
                onSelected: (_) {
                  setState(() {
                    _choicedIcon = Icons.sentiment_dissatisfied;
                  });
                },
              ),
              ChoiceChip(
                label: const Icon(
                  Icons.sentiment_very_dissatisfied,
                ),
                showCheckmark: false,
                selected: _choicedIcon == Icons.sentiment_very_dissatisfied,
                onSelected: (_) {
                  setState(() {
                    _choicedIcon = Icons.sentiment_very_dissatisfied;
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
            keyboardType: TextInputType.multiline,
            maxLines: null,
            minLines: 6,
            onChanged: (value) => ctrlrText.text = value,
          ),
        ],
      ),
      actions: actions,
    );
  }
}
