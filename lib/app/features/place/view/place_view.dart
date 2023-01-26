import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hookahorder_mobile/app/features/place/controller/place_controller.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class PlaceView extends GetView<PlaceController> {
  const PlaceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return YandexMap(
        mapObjects: controller.places.value,
        onMapCreated: controller.initYaMapController,
      );
    });
  }
}
