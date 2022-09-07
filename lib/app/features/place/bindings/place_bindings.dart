import 'package:get/get.dart';
import 'package:hookahorder_mobile/app/features/place/controller/place_controller.dart';
import 'package:hookahorder_mobile/app/features/place/repository/place_repository.dart';

class PlaceBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PlaceController());
    Get.lazyPut(() => PlaceRepository());
  }
}
