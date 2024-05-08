import 'package:flutter/material.dart';

class TodayTab extends StatefulWidget {
  final String displayText;
  final String? errorText;

  const TodayTab({
    super.key,
    this.displayText = '',
    this.errorText,
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
          widget.errorText ?? 'Today\n${widget.displayText}',
          textAlign: TextAlign.center,
          style: widget.errorText == null
              ? null
              : const TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}
