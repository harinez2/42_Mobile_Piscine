import 'package:flutter/material.dart';

class CurrentlyTab extends StatefulWidget {
  final String displayText;

  const CurrentlyTab({
    super.key,
    this.displayText = '',
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
          'Currently\n${widget.displayText}',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
