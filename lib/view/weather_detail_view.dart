import 'dart:ui';
import 'package:flutter/material.dart';
import '../model/weather_model.dart';

class WeatherDetailView extends StatelessWidget {
  final CurrentWeatherResponse weatherData;

  const WeatherDetailView({super.key, required this.weatherData});

  String _getWeatherIcon(String conditionText) {
    final condition = conditionText.toLowerCase();

    if (condition.contains('rain') || condition.contains('yağmur')) {
      return 'assets/icons/rain.png';
    } else if (condition.contains('sunny') || condition.contains('güneşli') || condition.contains('clear')) {
      return 'assets/icons/sunny.png';
    } else if (condition.contains('partly cloudy') || condition.contains('parçalı bulutlu')) {
      return 'assets/icons/cloudy.png';
    } else if (condition.contains('thundery') || condition.contains('fırtına') || condition.contains('şimşek')) {
      return 'assets/icons/lightning.png';
    } else {
      return 'assets/icons/sun_cloud.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFF2E1A47),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 260,
            child: Image.asset(
              'assets/icons/House.png',
              width: MediaQuery.of(context).size.width * 0.95,
              fit: BoxFit.contain,
            ),
          ),
          SafeArea(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  Text(
                    weatherData.location.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.3,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${weatherData.current.tempC.toInt()}°',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 90,
                      fontWeight: FontWeight.w200,
                      height: 1.1,
                    ),
                  ),
                  Text(
                    weatherData.current.condition.text,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.6),
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'H:${(weatherData.current.tempC + 2).toInt()}°   L:${(weatherData.current.tempC - 2).toInt()}°',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.38,
            minChildSize: 0.35,
            maxChildSize: 0.85,
            builder: (context, scrollController) {
              return ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(44)),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF48319D).withValues(alpha: 0.75),
                          const Color(0xFF1F1D47).withValues(alpha: 0.95),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(44)),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                    ),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          Container(
                            width: 48,
                            height: 5,
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.3),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          const SizedBox(height: 14),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 32),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Hourly Forecast",
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15),
                                ),
                                Text(
                                  "Weekly Forecast",
                                  style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontWeight: FontWeight.w600, fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                          Divider(color: Colors.white.withValues(alpha: 0.15), height: 24),
                          SizedBox(
                            height: 150,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              itemCount: 8,
                              separatorBuilder: (_, __) => const SizedBox(width: 12),
                              itemBuilder: (context, index) {
                                bool isSelected = index == 1;
                                return Container(
                                  width: 65,
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: isSelected ? const Color(0xFF48319D) : const Color(0xFF2E2B5C).withValues(alpha: 0.5),
                                    border: Border.all(
                                      color: isSelected ? Colors.white.withValues(alpha: 0.5) : Colors.white.withValues(alpha: 0.1),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(alpha: 0.2),
                                        blurRadius: 10,
                                        offset: const Offset(0, 4),
                                      )
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        index == 1 ? "Now" : "${(index * 2) % 12 + 1} AM",
                                        style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600),
                                      ),
                                      Image.asset(
                                        _getWeatherIcon(weatherData.current.condition.text),
                                        width: 32,
                                        height: 32,
                                        fit: BoxFit.contain,
                                      ),
                                      Text(
                                        '${weatherData.current.tempC.toInt()}°',
                                        style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 60),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}