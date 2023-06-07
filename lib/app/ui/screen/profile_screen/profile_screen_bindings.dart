import 'package:get/get.dart';
import 'package:hookahorder_mobile/app/services/user_service.dart';
import 'package:hookahorder_mobile/app/ui/screen/profile_screen/profile_screen_controller.dart';

class ProfileScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileScreenController());
    Get.lazyPut(() => UserService());
  }
}
