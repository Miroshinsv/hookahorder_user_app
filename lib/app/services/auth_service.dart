import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:hookahorder_mobile/app/models/auth_model/auth_response.dart';
import 'package:hookahorder_mobile/app/models/user_model/user_model.dart';
import 'package:hookahorder_mobile/app/network/api_client.dart';
import 'package:hookahorder_mobile/app/network/api_utils.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'storage_service.dart';

class AuthorizeService extends GetxService {
  final ApiClient _apiClient = ApiUtils.getApiClient();
  final StorageService _storageService = Get.find<StorageService>();
  static UserModel? _userModel;
  static AuthResponseModel? _authModel;

  static const _LOGIN_ENTITY_KEY = "login_entity";

  AuthResponseModel? get getCurrentAuthModel => _authModel;

  Future<AuthResponseModel> postAuthorize(String phone, String password) async {
    final response =
        await _apiClient.postLogin({"phone": phone, "password": password});
    _storageService.writeToStorage(_LOGIN_ENTITY_KEY, response);
    _authModel = response;
    final resp = await FirebaseMessaging.instance.getToken();
    if (resp != null) {
      await _apiClient.updateUserData(_userModel!.getId, {'fcm_token': resp});
    }
    return response;
  }

  Future<UserModel> postRegistration({
    required String phone,
    required String password,
  }) async {
    final response = await _apiClient
        .postRegistration({"phone": phone, "password": password});
    _userModel = response;
    return response;
  }

  Future<void> logOut() async {
    await _storageService.deleteFromStorage(_LOGIN_ENTITY_KEY);
    _authModel = null;
  }

  Future<int> getUserId() async {
    return JwtDecoder.decode(_authModel!.getAccessToken)['userId'];
  }

  @override
  void onInit() async {
    final resp = await _storageService.readFromStorage(_LOGIN_ENTITY_KEY);
    if (resp != null) {
      _authModel = AuthResponseModel.fromJson(resp);
      String? token = await FirebaseMessaging.instance.getToken();
      var userId = JwtDecoder.decode(_authModel!.getAccessToken)['userId'];
      if (!JwtDecoder.isExpired(_authModel!.getAccessToken)) {
        await _apiClient.updateUserData(userId, {"fcm_token": token});
      }
    }
    super.onInit();
  }

  Future<bool> checkIsUserLogin() async {
    return _authModel != null &&
        !JwtDecoder.isExpired(_authModel!.getAccessToken);
  }
}
