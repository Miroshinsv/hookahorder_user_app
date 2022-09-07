import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hookahorder_mobile/app/features/auth/entity/auth_request_entity.dart';
import 'package:hookahorder_mobile/app/features/place/entity/place_entity.dart';
import 'package:retrofit/retrofit.dart';

import '../features/auth/entity/auth_response_entity.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String? baseUrl}) =>
      _ApiClient(dio, baseUrl: baseUrl ?? dotenv.env['BASE_URL']);

  // AUTH
  @POST("/auth/login")
  Future<AuthResponseEntity> postAuthRequestEntity(
    @Part(name: 'email') String email,
    @Part(name: 'password') String password,
  );

  // PLACES
  @GET("/places/get/all")
  Future<List<PlaceEntity>> getAllPlaces();
}
