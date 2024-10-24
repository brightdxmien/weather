import 'package:flutter/cupertino.dart';
import 'package:weather/homepage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Weather());
}

class Weather extends StatelessWidget {
  const Weather({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CupertinoApp(
        home: WeatherScreen(),
      ),
    );
  }
}

CupertinoThemeData lightTheme = const CupertinoThemeData(
  primaryColor: CupertinoColors.systemBlue,
  scaffoldBackgroundColor: Color.fromARGB(255, 246, 251, 255),
);
