import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'app/routes/route_config.dart';
import 'app/services/auth_service.dart';
import 'app/services/storage_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await GetStorage.init();
  Get.put(StorageService());
  Get.put(AuthorizeService());
  runApp(
    GetMaterialApp(
      getPages: RouteConfig.getRoutes,
      initialRoute: RouteConfig.MAIN_SCREEN,
    ),
  );
}
