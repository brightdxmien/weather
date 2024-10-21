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

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: RefreshProgressIndicator(
          color: CupertinoColors.white,
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
      String cityName = "London";
      final result = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$cityName,uk&APPID=$opeenWeatherApi'));
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
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        middle: const Text(
          "Weather",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: CupertinoColors.systemGrey3,
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
            CupertinoIcons.refresh,
            color: CupertinoColors.systemGrey6,
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

            {
              return Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      elevation: 50,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Text(
                              "${celsius.toStringAsFixed(2)}°C",
                              style: const TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: CupertinoColors.white,
                              ),
                            ),
                            Icon(
                              condition == 'Clouds' || condition == 'Rain'
                                  ? CupertinoIcons.cloud_fill
                                  : CupertinoIcons.sun_min_fill,
                              size: 70,
                              color: CupertinoColors.white,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "$condition",
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
                    child: Text(
                      "Weather Forecast",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
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
                        final time = DateTime.parse(hourlyItem['dt_txt']);
                        final hourlySky =
                            data['list'][index + 1]['weather'][0]['main'];
                        return HourlyForecast(
                          temperature: hourlyItem['main']['temp'].toString(),
                          icon: hourlySky == "Clouds" || hourlySky == "Clear"
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
                        overflow: TextOverflow.ellipsis,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        AddInfo(
                          icon: CupertinoIcons.drop_fill,
                          title: "Wind Speed",
                          value: "$windSpeed",
                        ),
                        AddInfo(
                            icon: CupertinoIcons.drop_fill,
                            title: "Humidity",
                            value: "$humidity"),
                        AddInfo(
                          icon: CupertinoIcons.gauge,
                          title: "Pressure",
                          value: "$pressure",
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
