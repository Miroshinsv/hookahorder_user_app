import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:hookahorder_mobile/app/services/auth_service.dart';
import 'package:hookahorder_mobile/app/services/geolocator_service.dart';
import 'package:hookahorder_mobile/app/services/order_service.dart';
import 'package:hookahorder_mobile/app/services/place_service.dart';
import 'package:hookahorder_mobile/app/ui/screen/main_screen/wigets/modals.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MainScreenController extends GetxController {
  int currentPlaceId = 0;
  final RxBool visiblyErr = false.obs;
  final RxBool timeSelected = false.obs;
  final AuthorizeService _authorizeService = Get.find();
  final OrderService _orderService = Get.find();
  late YandexMapController _controller;
  var places = <PlacemarkMapObject>[].obs;
  final GeolocatorService _geolocationService = Get.find();
  final PlaceService _placeService = Get.find();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController commentController = TextEditingController();
  RxString selectedTime = "Выберите время".obs;

  // Крепкость табака
  RxString tabacoScore = "Легкий".obs;
  RxString tabacoTasty = "Цитрус".obs;

  Future<void> initYaController(YandexMapController controller) async {
    phoneController.text = "+7";
    _controller = controller;
    await _initPlaces();
    await centerMapOnUser();
  }

  Future<bool> checkUserLoggined() async {
    return _authorizeService.checkIsUserLogin();
  }

  Future<bool> postAuth() async {
    try {
      await _authorizeService.postAuthorize(phoneController.text.substring(1), passwordController.text);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> postRegistration() async {
    try {
      await _authorizeService.postRegistration(phone: phoneController.text.substring(1), password: passwordController.text);
      await _authorizeService.postAuthorize(phoneController.text.substring(1), passwordController.text);
      Get.back();
      return true;
    } catch (e) {
      controller.visiblyErr.value = true;
      Future.delayed(const Duration(seconds: 3))
          .then((value) => controller.visiblyErr.value = false);
      return false;
    }
  }

  Future<void> postOrder() async {
    _orderService.postOrder(
      placeId: currentPlaceId,
      userId: await _authorizeService.getUserId(),
      time: selectedTime.value,
      comment:
          "Вкус: $tabacoTasty\nКрепкость: $tabacoScore\nДополнительно:\n${commentController.text}",
    );
  }

  Future<void> centerMapOnUser() async {
    var currentPosition = await _geolocationService.getLastKnowPosition();
    _controller.moveCamera(
      CameraUpdate.newCameraPosition(
        const CameraPosition(
          target: Point(
            latitude: 55.919522728806136,
            longitude: 37.76273697330549,
          ),
        ),
      ),
    );
  }

  Future<void> zoomIn() async {
    _controller.moveCamera(CameraUpdate.zoomIn());
  }

  Future<void> zoomOut() async {
    _controller.moveCamera(CameraUpdate.zoomOut());
  }

  Future<void> _initPlaces() async {
    final currentPlaces = await _placeService.getAllPlaces();
    places.addAll(
      currentPlaces.map(
        (e) => PlacemarkMapObject(
          mapId: MapObjectId(e.name),
          point: Point(
            latitude: e.address.lat,
            longitude: e.address.lng,
          ),
          icon: PlacemarkIcon.single(
            PlacemarkIconStyle(
              image: BitmapDescriptor.fromAssetImage("assets/icons/place.png"),
            ),
          ),
          onTap: (object, point) {
            currentPlaceId = e.id;
            showModalBottomSheet(
              context: Get.context!,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20.0),
                ),
              ),
              builder: (context) {
                return SizedBox(
                  height: MediaQuery.of(context).copyWith().size.height * 0.4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Flexible(
                                child: Text(
                                  e.name,
                                  softWrap: true,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 26,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: Get.back,
                                icon: const Icon(Icons.close_outlined),
                                style: const ButtonStyle(
                                  iconColor: MaterialStatePropertyAll(
                                    Color.fromRGBO(39, 129, 129, 1),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Открыто до: ${e.endTime ?? "не указано"}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Divider(),
                                SizedBox(
                                  width: Get.mediaQuery.size.width * 0.6,
                                  child: Text(
                                    e.address.getAddress,
                                    style: const TextStyle(
                                      color: Color.fromRGBO(76, 140, 140, 1),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Image(
                              image: e.logo == null
                                  ? Image.asset("assets/icons/empty_logo.png")
                                      .image
                                  : Image.network(e.logo!).image,
                              width: Get.mediaQuery.size.width * 0.3,
                            ),
                          ],
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton(
                              onPressed: () async {
                                if (await checkUserLoggined()) {
                                  Get.back();
                                  Get.dialog(placeOrderDialog());
                                } else {
                                  Get.back();
                                  Get.dialog(needAuthDialog());
                                }
                              },
                              style: ButtonStyle(
                                backgroundColor: const MaterialStatePropertyAll(
                                  Color.fromRGBO(39, 129, 129, 1),
                                ),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "Забронировать столик",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Future<void> updateCameraPosition(Position updatePosition) async {
    _controller.moveCamera(
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
}
