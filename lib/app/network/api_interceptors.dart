import 'package:dio/dio.dart';
import 'package:get/get.dart' as libGet;


class ApiInterceptors extends InterceptorsWrapper {
  /// On request add JWT token to header.
  /// This need to make mobile requests

  // @override
  // void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
  //   final auth = libGet.Get.find<AuthorizeService>().getCurrentAuthModel;
  //   if (auth != null) {
  //     options.headers['Authorization'] =
  //         "${auth.getTokenType} ${auth.getAuthToken}";
  //   }
  //   print("###### REQUEST ######");
  //   print('URI: ${options.uri}');
  //   print('ContentType: ${options.contentType}');
  //   print('Method: ${options.method}');
  //   print('Data: ${options.data}');
  //   print('Headers: ${options.headers}');
  //   print("######");
  //   super.onRequest(options, handler);
  // }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print("###### ERROR ######");
    print('Trace: ${err.stackTrace}');
    print('Response: ${err.response}');
    print('Err: ${err}');
    print("######");
    super.onError(err, handler);
  }
}
