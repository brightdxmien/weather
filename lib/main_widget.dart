import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainWidget extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String city;
  final String weather;
  final double temperature;
  const MainWidget({
    super.key,
    required this.city,
    required this.iconColor,
    required this.weather,
    required this.temperature,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      color: CupertinoColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 43, 85, 236),
              const Color.fromARGB(240, 53, 149, 245),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(
                  city,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 228, 228, 228),
                  ),
                ),
                Text(
                  "${temperature.toStringAsFixed(2)}°C",
                  // "${celsius.toStringAsFixed(2)}°C",
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: CupertinoColors.white,
                  ),
                ),
                Icon(
                  icon,
                  color: iconColor,
                  // condition == 'Clouds' ||
                  //         condition == 'Rain'
                  //     ? CupertinoIcons.cloud_fill
                  //     : CupertinoIcons.sun_min_fill,
                  size: 70,
                ),
                const SizedBox(height: 10),
                Text(
                  weather,
                  // condition == 'Clouds' ||
                  //         condition == 'Rain'
                  //     ? "Cloudy"
                  //     : "Raining",
                  style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: CupertinoColors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
