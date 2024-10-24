import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:weather/daily_forecast.dart';
import 'package:weather/add_info.dart';
import 'package:weather/extra.dart';
import 'package:weather/main.dart';
export 'homepage.dart';
import 'package:weather/main_widget.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: RefreshProgressIndicator(
          color: CupertinoColors.systemBlue,
        ),
      ),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late Future weatherData;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    weatherData = getWeather();
  }

  Future<Map<String, dynamic>> getWeather() async {
    try {
      setState(() {
        _isLoading = true;
      });
      String cityName = "Lagos";
      final result = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$opeenWeatherApi'));
      final data = jsonDecode(result.body);
      if (data['cod'] != '200') {
        throw "An Error Occurred";
      }
      setState(() {
        _isLoading = false;
      });
      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: const BoxDecoration(
      //     gradient: LinearGradient(colors: [
      //   CupertinoColors.activeBlue,
      //   CupertinoColors.activeBlue,
      // ])),
      child: CupertinoTheme(
        data: lightTheme,
        child: CupertinoPageScaffold(
          // backgroundColor: CupertinoColors.activeBlue,
          navigationBar: CupertinoNavigationBar(
            backgroundColor: Color.fromARGB(255, 246, 251, 255),
            middle: const Text(
              "Weather",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: CupertinoColors.black,
              ),
            ),
            trailing: GestureDetector(
              onTap: () {
                setState(() {
                  _isLoading = true;
                  weatherData = getWeather();
                });
              },
              child: const Icon(
                size: 25.0,
                CupertinoIcons.restart,
                color: CupertinoColors.systemBlue,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: FutureBuilder(
              future: weatherData, // Correct Future call
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingScreen();
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  print("Snapshot Has Data");
                }

                final data = snapshot.data!;
                final currentTemp = data['list'][0]['main']['temp'];
                final pressure = data['list'][0]['main']['pressure'];
                final humidity = data['list'][0]['main']['humidity'];
                final condition = data['list'][0]['weather'][0]['main'];
                final windSpeed = data['list'][0]['wind']['speed'];
                final celsius = currentTemp - 272.15;
                // Color iconColor;
                // if (condition == "Clouds") {
                //   iconColor = CupertinoColors.systemGrey; // Color for clouds
                // } else if (condition == "Clear") {
                //   iconColor = CupertinoColors.systemBlue; // Color for rain
                // } else {
                //   iconColor = CupertinoColors
                //       .systemYellow; // Default color (e.g., for sun)
                // }

                {
                  return CustomScrollView(slivers: [
                    CupertinoSliverRefreshControl(onRefresh: () async {
                      setState(() {});
                      _isLoading = true;
                      weatherData = getWeather();
                    }),
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          MainWidget(
                              weather: condition,
                              temperature: celsius,
                              city: "Lagos",
                              icon:
                                  condition == "Clouds" || condition == "Clear"
                                      ? CupertinoIcons.cloud_fill
                                      : CupertinoIcons.sun_min_fill,
                              iconColor:
                                  condition == "Clouds" || condition == "Clear"
                                      ? CupertinoColors.white
                                      : CupertinoColors.systemYellow),
                          SizedBox(
                            width: double.infinity,
                          ),
                          const SizedBox(height: 40),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Hourly Forecast",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 19, 49, 88),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          // SingleChildScrollView(
                          //   scrollDirection: Axis.horizontal,
                          //   child: Row(
                          //     children: [
                          //       for (int i = 0; i < 20; i++)
                          //         HourlyForecast(
                          //           temperature:
                          //               data['list'][i + 1]['main']['temp'].toString(),
                          //           icon: data['list'][i + 1]['weather'][0]['main'] ==
                          //                       'Clouds' ||
                          //                   data['list'][i + 1]['weather'][0]['main'] ==
                          //                       'Clear'
                          //               ? CupertinoIcons.cloud_fill
                          //               : CupertinoIcons.sun_min_fill,
                          //           time: data['list'][i + 1]['dt'].toString(),
                          //         ),
                          //     ],
                          //   ),
                          // ),

                          SizedBox(
                            height: 160,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 20,
                              itemBuilder: (context, index) {
                                final hourlyItem = data['list'][index + 1];
                                final time =
                                    DateTime.parse(hourlyItem['dt_txt']);
                                final miniTemp = hourlyItem['main']['temp'];
                                final miniTemp2 = miniTemp - 272.15;

                                final hourlySky = data['list'][index + 1]
                                    ['weather'][0]['main'];
                                Color iconColor;
                                if (hourlySky == "Clouds") {
                                  iconColor = CupertinoColors
                                      .systemGrey; // Color for clouds
                                } else if (hourlySky == "Clear") {
                                  iconColor = CupertinoColors
                                      .systemBlue; // Color for rain
                                } else {
                                  iconColor = CupertinoColors
                                      .systemYellow; // Default color (e.g., for sun)
                                }

                                return HourlyForecast(
                                  iconColor: iconColor,
                                  temperature:
                                      "${miniTemp2.toStringAsFixed(0)}°C",
                                  icon: hourlySky == "Clouds" ||
                                          hourlySky == "Clear"
                                      ? CupertinoIcons.cloud_fill
                                      : CupertinoIcons.sun_min_fill,
                                  time: DateFormat.Hm().format(time),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 40),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Additional Information",
                              style: TextStyle(
                                color: Color.fromARGB(255, 19, 49, 88),
                                overflow: TextOverflow.ellipsis,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Card(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    AddInfo(
                                      iconColor: CupertinoColors.systemBlue,
                                      icon: CupertinoIcons.wind,
                                      title: "Wind Speed",
                                      value: "$windSpeed",
                                    ),
                                    AddInfo(
                                        iconColor: CupertinoColors.activeGreen,
                                        icon: (CupertinoIcons.drop_fill),
                                        title: "Humidity",
                                        value: "$humidity"),
                                    AddInfo(
                                      iconColor: CupertinoColors.systemRed,
                                      icon: CupertinoIcons.gauge,
                                      title: "Pressure",
                                      value: "$pressure",
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]);
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
