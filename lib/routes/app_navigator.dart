import 'package:get/get.dart';
import '../models/enterprise_model.dart';
import 'app_routes.dart';

class AppNavigator {
  static void openHome() {
    Get.toNamed(AppRoutes.home);
  }

  static void openTreePage({required EnterpriseModel enterpriseModel}) {
    Get.toNamed(AppRoutes.treePage, arguments: enterpriseModel);
  }
}
