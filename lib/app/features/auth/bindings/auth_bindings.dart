import 'package:get/get.dart';
import 'package:hookahorder_mobile/app/features/auth/controller/auth_controller.dart';
import 'package:hookahorder_mobile/app/features/auth/repository/auth_repository.dart';

class AuthBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => AuthRepository());
  }
}
