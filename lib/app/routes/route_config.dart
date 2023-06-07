import 'package:get/get.dart';
import 'package:hookahorder_mobile/app/ui/screen/main_screen/main_screen_bindings.dart';
import 'package:hookahorder_mobile/app/ui/screen/main_screen/main_screen_view.dart';
import 'package:hookahorder_mobile/app/ui/screen/profile_screen/profile_screen_bindings.dart';
import 'package:hookahorder_mobile/app/ui/screen/profile_screen/profile_screen_view.dart';

class RouteConfig {
  static String MAIN_SCREEN = '/main';
  static String PROFILE_SCREEN = '/profile';

  static get getRoutes => [
        GetPage(
          name: MAIN_SCREEN,
          page: () => const MainScreen(),
          binding: MainScreenBindings(),
        ),
        GetPage(
          name: PROFILE_SCREEN,
          page: () => const ProfileScreen(),
          binding: ProfileScreenBindings(),
        ),
      ];
}
