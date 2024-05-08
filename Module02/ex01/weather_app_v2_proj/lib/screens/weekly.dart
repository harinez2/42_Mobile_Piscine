import 'package:flutter/material.dart';

class WeeklyTab extends StatefulWidget {
  final String displayText;
  final String? errorText;

  const WeeklyTab({
    super.key,
    this.displayText = '',
    this.errorText,
  });

  @override
  WeeklyTabState createState() => WeeklyTabState();
}

class WeeklyTabState extends State<WeeklyTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          widget.errorText ?? 'Weekly\n${widget.displayText}',
          textAlign: TextAlign.center,
          style: widget.errorText == null
              ? null
              : const TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}
