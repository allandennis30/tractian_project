import 'package:get/get.dart';
import 'app_routes.dart';

class AppNavigator {
  static void openHome() {
    Get.toNamed(AppRoutes.home);
  }

  static void openTreePage() {
    Get.toNamed(AppRoutes.treePage);
  }
}
