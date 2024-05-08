import 'package:flutter/material.dart';

class CurrentlyTab extends StatefulWidget {
  final String displayText;
  final String? errorText;

  const CurrentlyTab({
    super.key,
    this.displayText = '',
    this.errorText,
  });

  @override
  CurrentlyTabState createState() => CurrentlyTabState();
}

class CurrentlyTabState extends State<CurrentlyTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          widget.errorText ?? 'Currently\n${widget.displayText}',
          textAlign: TextAlign.center,
          style: widget.errorText == null
              ? null
              : const TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}
