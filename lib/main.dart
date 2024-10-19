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
    return const CupertinoApp(
      theme: CupertinoThemeData(brightness: Brightness.dark),
      home: WeatherScreen(),
    );
  }
}
