import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'routes/app_routes.dart';

class TractianAppRun extends StatelessWidget {
  const TractianAppRun({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.home,
      getPages: AppRoutes.routes,
    );
  }
}
