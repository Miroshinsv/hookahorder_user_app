// import 'package:get/get.dart';
// import 'package:hookahorder_mobile/app/models/auth/auth_response.dart';
// import 'package:hookahorder_mobile/app/network/api_client.dart';
// import 'package:hookahorder_mobile/app/network/api_utils.dart';
//
//
// import 'storage_service.dart';
//
// class AuthorizeService extends GetxService {
//   final ApiClient _apiClient = ApiUtils.getApiClient();
//   final StorageService _storageService = Get.find<StorageService>();
//   static AuthResponseModel? _authModel;
//
//   static const _LOGIN_ENTITY_KEY = "login_entity";
//
//   AuthResponseModel? get getCurrentAuthModel => _authModel;
//
//   // Future<AuthResponseModel> postAuthorize(String phone, String password) async {
//   //   final response = await _apiClient(
//   //     entity.phone,
//   //     entity.password,
//   //   );
//   //   _storageService.writeToStorage(_LOGIN_ENTITY_KEY, response);
//   //   _authModel = response;
//   //   return response;
//   // }
//
//   Future<void> logOut() async {
//     await _storageService.deleteFromStorage(_LOGIN_ENTITY_KEY);
//     _authModel = null;
//   }
//
//   @override
//   void onInit() async {
//     final resp = await _storageService.readFromStorage(_LOGIN_ENTITY_KEY);
//     if (resp != null) {
//       _authModel = AuthResponseEntity.fromJson(resp);
//     }
//     super.onInit();
//   }
//
//   Future<bool> checkIsUserLogin() async {
//     return _authModel != null;
//   }
// }
