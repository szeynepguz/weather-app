import 'package:flutter/material.dart';
import '../model/weather_model.dart';
import '../service/weather_service.dart';

class WeatherController extends ChangeNotifier {
  bool isLoading = false;
  String? errorMessage;

  List<CurrentWeatherResponse> weatherList = [];

  final List<String> cities = ['Ankara', 'Istanbul', 'Izmir', 'Antalya', 'Trabzon'];

  Future<void> getWeather(String location) async {
    isLoading = true;
    errorMessage = null;
    weatherList.clear();
    notifyListeners();

    try {
      for (String city in cities) {
        final response = await WeatherService.getCurrentWeather(city);

        weatherList.add(CurrentWeatherResponse.fromJson(response.data));
      }
    } catch (e) {
      errorMessage = 'Hava durumu alınamadı.';
    }

    isLoading = false;
    notifyListeners();
  }
}