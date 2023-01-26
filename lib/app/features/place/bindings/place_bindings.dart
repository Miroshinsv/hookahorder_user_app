import 'package:get/get.dart';
import 'package:hookahorder_mobile/app/features/place/controller/place_controller.dart';

class PlaceBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PlaceController());
  }
}
