import 'package:get/get.dart';

import '../pages/home_page/home_page.dart';
import '../pages/tree_page/tree_page.dart';

class AppRoutes {
  static const String home = '/';
  static const String treePage = '/treePage';

  static List<GetPage> routes = [
    GetPage(name: home, page: () => const HomePage()),
    GetPage(name: treePage, page: () => const TreePage()),
  ];
}
