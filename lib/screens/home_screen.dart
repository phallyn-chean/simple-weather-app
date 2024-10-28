import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/stores/weather_store.dart';
import 'package:weather_app/widgets/weather_icon_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    if (mounted) {
      getWeather();
    }
  }

  Future<void> getWeather() async {
    // ignore: deprecated_member_use
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    // ignore: use_build_context_synchronously
    await context.read<WeatherStore>().fetchWeather(position);
  }

  String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          systemOverlayStyle: const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(40, 1.2 * kTextTabBarHeight, 40, 20),
          child: Observer(
            builder: (_) {
              WeatherStore store = context.watch<WeatherStore>();
              if (store.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (store.errorMessage != null) {
                return Center(
                  child: Text("Error: ${store.errorMessage}"),
                );
              }
              if (store.weather != null) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                    children: [
                      Align(
                        alignment: const AlignmentDirectional(3, -0.3),
                        child: Container(
                          height: 300,
                          width: 300,
                          decoration: const BoxDecoration(
                            color: Colors.deepPurple,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Align(
                        alignment: const AlignmentDirectional(-3, -0.3),
                        child: Container(
                          height: 300,
                          width: 300,
                          decoration: const BoxDecoration(
                            color: Colors.deepPurple,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Align(
                        alignment: const AlignmentDirectional(0, -1.2),
                        child: Container(
                          height: 300,
                          width: 300,
                          decoration: const BoxDecoration(
                            color: Color(0xFFFFAB40),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "📍 ${store.weather?.areaName}",
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              getGreeting(),
                              style: const TextStyle(color: Colors.white, fontSize: 25),
                            ),
                            WeatherIconWidget(code: store.weather!.weatherConditionCode!),
                            Center(
                              child: Text(
                                "${store.weather!.temperature!.celsius!.round()} °C",
                                style: const TextStyle(fontSize: 55, fontWeight: FontWeight.w600, color: Colors.white),
                              ),
                            ),
                            Center(
                              child: Text(
                                store.weather!.weatherMain!.toUpperCase(),
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 25),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Center(
                              child: Text(
                                DateFormat("EEEE dd •").add_jm().format(store.weather!.date!),
                                style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w300),
                              ),
                            ),
                            const SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset("assets/11.png", scale: 8),
                                    const SizedBox(width: 5),
                                    Column(
                                      children: [
                                        const Text(
                                          "Sunrise",
                                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
                                        ),
                                        const SizedBox(height: 3),
                                        Text(
                                          DateFormat().add_jm().format(store.weather!.sunrise!),
                                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Image.asset("assets/12.png", scale: 8),
                                    const SizedBox(width: 5),
                                    Column(
                                      children: [
                                        const Text(
                                          "Sunset",
                                          style: TextStyle(fontWeight: FontWeight.w300, color: Colors.white),
                                        ),
                                        const SizedBox(height: 3),
                                        Text(
                                          DateFormat().add_jm().format(store.weather!.sunset!),
                                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: Divider(color: Colors.grey),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset("assets/13.png", scale: 8),
                                    const SizedBox(width: 5),
                                    Column(
                                      children: [
                                        const Text(
                                          "Temp Max",
                                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
                                        ),
                                        const SizedBox(height: 3),
                                        Text(
                                          "${store.weather!.tempMax!.celsius!.round()}°C",
                                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Image.asset("assets/14.png", scale: 8),
                                    const SizedBox(width: 5),
                                    Column(
                                      children: [
                                        const Text(
                                          "Temp Min",
                                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
                                        ),
                                        const SizedBox(height: 3),
                                        Text(
                                          "${store.weather!.tempMin!.celsius!.round()}°C",
                                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ));
  }
}
