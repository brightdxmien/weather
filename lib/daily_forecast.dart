import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HourlyForecast extends StatelessWidget {
  final String time;
  final IconData icon;
  final String temperature;
  final Color iconColor;
  const HourlyForecast({
    super.key,
    required this.temperature,
    required this.icon,
    required this.time,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: Card(
        elevation: 3,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              colors: [
                const Color.fromARGB(255, 255, 255, 255),
                const Color.fromARGB(239, 250, 250, 250),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
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
                  color: iconColor,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(temperature),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
