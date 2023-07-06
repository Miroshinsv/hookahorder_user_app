import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/routes/route_config.dart';
import 'app/services/geolocator_service.dart';
import 'app/services/place_service.dart';
import 'app/services/storage_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  await GetStorage.init();
  Get.put(StorageService());
  Get.put(GeolocatorService());
  Get.put(PlaceService());
  runApp(
    GetMaterialApp(
      getPages: RouteConfig.getRoutes,
      initialRoute: RouteConfig.MAIN_SCREEN,
    ),
  );
}
