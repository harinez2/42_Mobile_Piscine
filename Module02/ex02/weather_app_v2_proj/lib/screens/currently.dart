import 'package:flutter/material.dart';

class CurrentlyTab extends StatefulWidget {
  final Map<String, dynamic> geoData;
  final String? errorText;

  const CurrentlyTab({
    super.key,
    this.geoData = const {},
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
          widget.errorText ??
              (widget.geoData['name'] != null
                  ? 'Currently\n${widget.geoData['name']}'
                  : 'Currently\n'),
          textAlign: TextAlign.center,
          style: widget.errorText == null
              ? null
              : const TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}
