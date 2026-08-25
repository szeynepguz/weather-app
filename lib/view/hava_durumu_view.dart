import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/weather_controller.dart';
import '../view/weather_detail_view.dart';

class WeatherList extends StatelessWidget {
  const WeatherList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<WeatherController>();

    if (controller.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (controller.weatherList.isEmpty) {
      return const Center(
        child: Text(
          'Hava durumu bulunamadı',
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: controller.weatherList.length,
      itemBuilder: (context, index) {
        

        return Container(
          height: 140,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFF5732B5),
                Color(0xFF43258A),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(18),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WeatherDetailView(weatherData: controller.weatherList[index]),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${controller.weatherList[index].current.tempC.toInt()}°',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'H:${(controller.weatherList[index].current.tempC + 2).toInt()}° '
                            'L:${(controller.weatherList[index].current.tempC - 2).toInt()}°',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.75),
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '${controller.weatherList[index].location.name}, ${controller.weatherList[index].location.country}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Image.asset(
                      'assets/icons/rain.png',
                      width: 80,
                      height: 80,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}