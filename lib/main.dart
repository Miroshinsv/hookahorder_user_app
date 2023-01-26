import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/routes/route_config.dart';
import 'app/services/storage_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Get.put(StorageService());
  runApp(
    GetMaterialApp(
      getPages: RouteConfig.getRoutes,
      initialRoute: RouteConfig.MAIN_SCREEN,
    ),
  );
}
