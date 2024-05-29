import 'package:flutter/material.dart';

class ErrorDisplay extends StatelessWidget {
  final String? errorText;

  const ErrorDisplay({
    super.key,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Text(
          errorText ?? '',
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}
