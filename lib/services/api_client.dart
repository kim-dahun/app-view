import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'api_service.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  late final ApiService service;
  final Logger logger = Logger();

  factory ApiClient() {
    return _instance;
  }

  ApiClient._internal() {
    final dio = Dio();

    // Dio 인터셉터 설정 (로깅 등)
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        logger.d('REQUEST[${options.method}] => PATH: ${options.path}');
        return handler.next(options);
      },
      onResponse: (response, handler) {
        logger.d('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        logger.e('ERROR[${e.response?.statusCode}] => PATH: ${e.requestOptions.path}');
        return handler.next(e);
      },
    ));

    service = ApiService(dio, baseUrl: 'https://localhost:4000/api');
  }
}