import 'package:dio/dio.dart';

class ApiService {
  static final _instance = ApiService();
  factory ApiService() => _instance;
  static Dio dio = Dio()
    ..options = BaseOptions(
        baseUrl: "https://newsapi.org/v2/",
        connectTimeout: const Duration(seconds: 600),
        receiveTimeout: const Duration(seconds: 600),
        // sendTimeout: const Duration(seconds: 600)
        );
  static Future<Response> get(
      {required String path, Map<String, dynamic>? queryParameters}) async {
    try {
      final Response response =
          await dio.get(path, queryParameters: queryParameters);
      return response;
    } on DioException catch (e) {
      throw Exception(e);
    }
  }
}
