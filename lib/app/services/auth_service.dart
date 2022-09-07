import 'package:get/get.dart';
import 'package:hookahorder_mobile/app/features/auth/entity/auth_request_entity.dart';

import '../features/auth/entity/auth_response_entity.dart';
import '../network/api_client.dart';
import '../network/api_utils.dart';
import 'storage_service.dart';

class AuthorizeService extends GetxService {
  final ApiClient _apiClient = ApiUtils.getApiClient();
  final StorageService _storageService = Get.find<StorageService>();
  static AuthResponseEntity? _responseEntity;

  static const _LOGIN_ENTITY_KEY = "login_entity";

  AuthResponseEntity? get getCurrentLoginEntity => _responseEntity;

  Future<AuthResponseEntity> postAuthorize(AuthRequestEntity entity) async {
    final response = await _apiClient.postAuthRequestEntity(
      entity.phone,
      entity.password,
    );
    _storageService.writeToStorage(_LOGIN_ENTITY_KEY, response);
    _responseEntity = response;
    return response;
  }

  Future<void> logOut() async {
    await _storageService.deleteFromStorage(_LOGIN_ENTITY_KEY);
    _responseEntity = null;
  }

  @override
  void onInit() async {
    final resp = await _storageService.readFromStorage(_LOGIN_ENTITY_KEY);
    if (resp != null) {
      _responseEntity = AuthResponseEntity.fromJson(resp);
    }
    super.onInit();
  }

  Future<bool> checkIsUserLogin() async {
    return _responseEntity != null;
  }
}
