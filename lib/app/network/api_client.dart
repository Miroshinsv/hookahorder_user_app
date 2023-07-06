import 'package:dio/dio.dart';
import 'package:hookahorder_mobile/app/models/auth_model/auth_response.dart';
import 'package:hookahorder_mobile/app/models/place_model/place_model.dart';
import 'package:hookahorder_mobile/app/models/user_model/user_model.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: "http://hookahorder.ru")
abstract class ApiClient {
  factory ApiClient(Dio dio, {String? baseUrl}) =>
      _ApiClient(dio, baseUrl: baseUrl);

  // PLACES
  @GET("/place/get/all")
  Future<List<PlaceModel>> getAllPlaces();

  // AUTH
  @POST('/auth/login')
  Future<AuthResponseModel> postLogin(@Body() Map<String, dynamic> cred);

  // ORDER
  @POST('/order/create/')
  Future<void> postOrder(@Body() Map<String, dynamic> cred);

  // USER
  @GET('/user/get/{userId}')
  Future<UserModel> getUserById(@Path("userId") userId);

  @POST('/user/create')
  Future<UserModel> postRegistration(@Body() Map<String, dynamic> cred);

  @PUT('/user/update/{id}')
  Future<UserModel> updateFCMToken(
      @Path("id") int userId, @Body() Map<String, dynamic> body);
}
