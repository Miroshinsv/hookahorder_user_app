import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class PlaceController extends GetxController {
  late YandexMapController controller;
  var places = <PlacemarkMapObject>[].obs;

  Future<void> initYaMapController(YandexMapController controller) async {
    this.controller = controller;
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    controller.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: Point(
            latitude: position.latitude,
            longitude: position.longitude,
          ),
        ),
      ),
    );
    places.add(
      PlacemarkMapObject(
        onTap: (object, point) {
          Get.defaultDialog(
            title: object.mapId.value,
            content: Column(
              children: [
                Text("Кальяшка"),
                Text("Оч вкусная"),
                TextButton(onPressed: (){}, child: Text("Заказать"),),
                TextButton(onPressed: (){}, child: Text("Подробнее"),),
              ],
            )
          );
        },
        icon: PlacemarkIcon.single(PlacemarkIconStyle(
            image: BitmapDescriptor.fromAssetImage('lib/assets/place.png'),
            rotationType: RotationType.rotate)),
        mapId: MapObjectId("place"),
        point: Point(
          latitude: position.latitude,
          longitude: position.longitude,
        ),
      ),
    );
  }

  Future<void> updateCameraPosition(Position updatePosition) async {
    controller.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: Point(
            latitude: updatePosition.latitude,
            longitude: updatePosition.longitude,
          ),
        ),
      ),
    );
  }

  @override
  Future<void> onInit() async {
    super.onInit();
  }
}
