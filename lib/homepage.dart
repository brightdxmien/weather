import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:weather/daily_forecast.dart';
import 'package:weather/add_info.dart';
import 'package:http/http.dart' as http;
import 'package:weather/extra.dart';
export 'homepage.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: Center(
      child: CircularProgressIndicator(),
    ));
  }
}

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late double temp = 0;
  @override
  void initState() {
    super.initState();
    getWeather();
  }

  Future getWeather() async {
    try {
      String cityName = "London";
      final result = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$cityName,uk&APPID=$opeenWeatherApi'));
      final data = jsonDecode(result.body);
      if (data['cod'] != '200') {
        throw "An Error Occured";
      }
      setState(() {
        temp = data['list'][0]['main']['temp'];
      });
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
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
          child: temp == 0
              ? LoadingScreen()
              : Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        elevation: 50,
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Text(
                                "$temp °C",
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
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: const Row(
                        children: [
                          DailyForecast(
                            day: "Monday",
                            icon: CupertinoIcons.cloud_fill,
                            time: "10:50",
                          ),
                          DailyForecast(
                            day: "Tuesday",
                            icon: CupertinoIcons.cloud_sun_fill,
                            time: "09:00",
                          ),
                          DailyForecast(
                            day: "Monday",
                            icon: CupertinoIcons.cloud_rain_fill,
                            time: "10:50",
                          ),
                          DailyForecast(
                            day: "Monday",
                            icon: CupertinoIcons.cloud_sun_bolt_fill,
                            time: "10:50",
                          ),
                          DailyForecast(
                            day: "Monday",
                            icon: CupertinoIcons.cloud_rain_fill,
                            time: "10:50",
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "Additional Information",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
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
