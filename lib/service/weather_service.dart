import 'package:dio/dio.dart';
import '../helper/dio_helper.dart';

class WeatherService {
  static const String apiKey = '6a3292ea1fb048d68bf53726262508';

  static Future<Response> getCurrentWeather(String location) async {
    return await DioHelper.get(
      endpoint: '/current.json',
      queryParameters: {
        'key': apiKey,
        'q': location,
        'aqi': 'no',
      },
    );
  }
}