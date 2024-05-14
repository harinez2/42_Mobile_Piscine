import 'package:flutter/material.dart';

class WeeklyTab extends StatefulWidget {
  final Map<String, dynamic> geoData;
  final String? errorText;

  const WeeklyTab({
    super.key,
    this.geoData = const {},
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
          widget.errorText ??
              (widget.geoData['name'] != null
                  ? 'Weekly\n${widget.geoData['name']}'
                  : 'Weekly\n'),
          textAlign: TextAlign.center,
          style: widget.errorText == null
              ? null
              : const TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}
