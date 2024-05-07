import 'package:flutter/material.dart';

class TodayTab extends StatefulWidget {
  final String displayText;

  const TodayTab({
    super.key,
    this.displayText = '',
  });

  @override
  TodayTabState createState() => TodayTabState();
}

class TodayTabState extends State<TodayTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Today\n${widget.displayText}',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
