import 'package:get/get.dart';
import 'package:hookahorder_mobile/app/features/place/bindings/place_bindings.dart';
import 'package:hookahorder_mobile/app/features/place/view/place_view.dart';

class RouteConfig {
  static String MAIN_SCREEN = '/main';

  static get getRoutes => [
        GetPage(
          name: MAIN_SCREEN,
          page: () => const PlaceView(),
          binding: PlaceBindings(),
        ),
      ];
}
