import 'package:flutter/material.dart';

class TodayTab extends StatefulWidget {
  final Map<String, dynamic> geoData;
  final String? errorText;

  const TodayTab({
    super.key,
    this.geoData = const {},
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
          widget.errorText ??
              (widget.geoData['name'] != null
                  ? 'Today\n${widget.geoData['name']}'
                  : 'Today\n'),
          textAlign: TextAlign.center,
          style: widget.errorText == null
              ? null
              : const TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}
