import 'package:dio/dio.dart';

class DioHelper {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.weatherapi.com/v1',
    ),
  );

  static Future<Response> get({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await dio.get(
      endpoint,
      queryParameters: queryParameters,
    );

    return response;
  }
}