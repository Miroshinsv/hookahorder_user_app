import 'package:dio/dio.dart';
import 'package:get/get.dart' as libGet;
import 'package:hookahorder_mobile/app/services/auth_service.dart';

class ApiInterceptors extends InterceptorsWrapper {
  /// On request add JWT token to header.
  /// This need to make mobile requests

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final auth = libGet.Get.find<AuthorizeService>().getCurrentAuthModel;
    if (auth != null) {
      options.headers['Authorization'] =
          "${auth.getTokenType} ${auth.getAccessToken}";
    }
    super.onRequest(options, handler);
  }
}
