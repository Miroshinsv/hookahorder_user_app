import 'package:dio/dio.dart';

import 'api_client.dart';
import 'api_interceptors.dart';

class ApiUtils {
  static Dio? _dio;

  static Dio getDio() {
    if (_dio == null) {
      _dio = Dio();
      _dio!.options.connectTimeout = const Duration(seconds: 10);
      _dio!.interceptors.add(ApiInterceptors());
    }
    return _dio!;
  }

  static ApiClient getApiClient({String? baseUrl}) {
    return ApiClient(getDio(), baseUrl: baseUrl);
  }
}
