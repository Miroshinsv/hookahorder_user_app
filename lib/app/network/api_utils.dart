import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'api_client.dart';
import 'api_interceptors.dart';

class ApiUtils {
  static Dio? _dio;

  static Dio getDio() {
    if (_dio == null) {
      _dio = Dio();
      _dio!.options.connectTimeout = 18000;
      _dio!.interceptors.add(ApiInterceptors());
      _dio!.options.baseUrl = dotenv.env['BASE_URL']!;
    }
    return _dio!;
  }

  static ApiClient getApiClient({String? baseUrl}) {
    return ApiClient(getDio(), baseUrl: baseUrl);
  }
}
