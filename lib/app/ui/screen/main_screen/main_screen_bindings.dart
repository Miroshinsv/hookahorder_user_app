import 'package:get/get.dart';
import 'package:hookahorder_mobile/app/services/auth_service.dart';
import 'package:hookahorder_mobile/app/services/order_service.dart';
import 'package:hookahorder_mobile/app/ui/screen/main_screen/main_screen_controller.dart';

class MainScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainScreenController());
    Get.lazyPut(() => AuthorizeService());
    Get.lazyPut(() => OrderService());
  }
}
