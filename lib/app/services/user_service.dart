import 'package:get/get.dart';
import 'package:hookahorder_mobile/app/models/user_model/user_model.dart';
import 'package:hookahorder_mobile/app/network/api_client.dart';
import 'package:hookahorder_mobile/app/network/api_utils.dart';

class UserService extends GetxService {
  final ApiClient _apiClient = ApiUtils.getApiClient();

  Future<UserModel> getUserById(int userId) {
    return _apiClient.getUserById(userId);
  }

  Future<UserModel> updateFCMToken(int userId, String token) async {
    return await _apiClient.updateUserData(userId, {'fcm_token': token});
  }

  Future<UserModel> updateUser(
      int userId, String userFirstName, String email) async {
    return await _apiClient
        .updateUserData(userId, {'name': userFirstName, "email": email});
  }
}
