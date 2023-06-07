import 'package:get/get.dart';
import 'package:hookahorder_mobile/app/models/user_model/user_model.dart';
import 'package:hookahorder_mobile/app/services/auth_service.dart';
import 'package:hookahorder_mobile/app/services/user_service.dart';

class ProfileScreenController extends GetxController {
  Rxn<UserModel> currenUser = Rxn();
  final UserService _userService = Get.find();
  final AuthorizeService _authorizeService = Get.find();

  Future<UserModel> getUserById() async {
    currenUser.value = await _userService.getUserById(await _authorizeService.getUserId());
    return currenUser.value!;
  }

  Future<void> logout() async {
    await _authorizeService.logOut();
  }
}
