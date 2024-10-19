import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:weather/daily_forecast.dart';
import 'package:weather/add_info.dart';

export 'homepage.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.black,
        middle: const Text(
          "Weather App",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: CupertinoColors.systemGrey3,
          ),
        ),
        trailing: GestureDetector(
            onTap: () {
              debugPrint("Pressed");
            },
            child: const Icon(
              size: 25.0,
              CupertinoIcons.refresh,
              // progress: _animationController,
              color: CupertinoColors.systemGrey6,
            )),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 8,
            right: 8,
          ),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  elevation: 50,
                  child: const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Text(
                          "300°C",
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: CupertinoColors.white,
                          ),
                        ),
                        Icon(
                          CupertinoIcons.cloud_fill,
                          size: 70,
                          color: CupertinoColors.white,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Cloudy",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              const Align(
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Weather Forecast",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: const Row(
                  children: [
                    DailyForecast(),
                    DailyForecast(),
                    DailyForecast(),
                    DailyForecast(),
                    DailyForecast(),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              const Align(
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Additional Information",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    AddInfo(
                      icon: CupertinoIcons.drop_fill,
                      title: "Humidity",
                      value: "80",
                    ),
                    AddInfo(
                      icon: CupertinoIcons.wind,
                      title: "Wind Speed",
                      value: "89",
                    ),
                    AddInfo(
                      icon: CupertinoIcons.gauge,
                      title: "Pressure",
                      value: "100",
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
