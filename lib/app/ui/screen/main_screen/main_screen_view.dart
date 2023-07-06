import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hookahorder_mobile/app/routes/route_config.dart';
import 'package:hookahorder_mobile/app/ui/screen/main_screen/main_screen_controller.dart';
import 'package:hookahorder_mobile/app/ui/screen/main_screen/wigets/modals.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MainScreen extends GetView<MainScreenController> {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () async {
                await controller.checkUserLoggined()
                    ? Get.toNamed(RouteConfig.PROFILE_SCREEN,
                        arguments: controller)
                    : Get.dialog(needAuthDialog());
              },
              icon: Image.asset(
                "assets/icons/profile_icon.png",
              ),
            ),
            const Divider(),
            Container(
              decoration: const BoxDecoration(
                color: Color.fromRGBO(39, 129, 129, 1),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(10.0),
                ),
              ),
              child: IconButton(
                onPressed: controller.zoomIn,
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: Color.fromRGBO(39, 129, 129, 1),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(10.0),
                ),
              ),
              child: IconButton(
                onPressed: controller.zoomOut,
                icon: const Icon(
                  Icons.remove,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                color: const Color.fromRGBO(39, 129, 129, 1),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: IconButton(
                onPressed: controller.centerMapOnUser,
                icon: const Icon(
                  Icons.navigation,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        body: Obx(() {
          return YandexMap(
            mapObjects: controller.places.value,
            onMapCreated: controller.initYaController,
          );
        }),
      ),
    );
  }
}
