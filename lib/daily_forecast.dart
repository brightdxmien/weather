import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DailyForecast extends StatelessWidget {
  const DailyForecast({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 120,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(
                "90:40",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Icon(
                CupertinoIcons.cloud_fill,
                color: CupertinoColors.white,
              ),
              SizedBox(
                height: 10,
              ),
              Text("Monday"),
            ],
          ),
        ),
      ),
    );
  }
}
