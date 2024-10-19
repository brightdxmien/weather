import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DailyForecast extends StatelessWidget {
  final String time;
  final IconData icon;
  final String day;
  const DailyForecast({
    super.key,
    required this.day,
    required this.icon,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(
                time,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Icon(
                icon,
                color: CupertinoColors.white,
              ),
              SizedBox(
                height: 10,
              ),
              Text(day),
            ],
          ),
        ),
      ),
    );
  }
}
