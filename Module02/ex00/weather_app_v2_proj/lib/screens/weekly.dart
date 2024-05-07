import 'package:flutter/material.dart';

class WeeklyTab extends StatefulWidget {
  final String displayText;

  const WeeklyTab({
    super.key,
    this.displayText = '',
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
          'Weekly\n${widget.displayText}',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
