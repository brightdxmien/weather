import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HourlyForecast extends StatelessWidget {
  final String time;
  final IconData icon;
  final String temperature;
  const HourlyForecast({
    super.key,
    required this.temperature,
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
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                time,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Icon(
                icon,
                color: CupertinoColors.white,
              ),
              SizedBox(
                height: 20,
              ),
              Text(temperature),
            ],
          ),
        ),
      ),
    );
  }
}
