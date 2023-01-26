import 'package:dio/dio.dart';
import 'package:hookahorder_mobile/app/models/place_model/place_model.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: "https://hookahorder.ru")
abstract class ApiClient {
  factory ApiClient(Dio dio, {String? baseUrl}) =>
      _ApiClient(dio, baseUrl: baseUrl);

  // PLACES
  @GET("/places/get/all")
  Future<List<PlaceModel>> getAllPlaces();
}
