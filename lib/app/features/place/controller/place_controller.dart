import 'package:get/get.dart';
import 'package:hookahorder_mobile/app/features/place/repository/place_repository.dart';

import '../entity/place_entity.dart';

class PlaceController extends GetxController {
  RxList<PlaceEntity> places = RxList();
  final PlaceRepository _placeRepository = Get.find();

  @override
  Future<void> onInit() async {
    places.value = await _placeRepository.getAllPlaces();
    super.onInit();
  }
}
