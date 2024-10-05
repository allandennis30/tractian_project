import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_tractian/pages/home_page/home_page_controller.dart';
import 'package:project_tractian/routes/app_navigator.dart';
import 'package:project_tractian/theme/tractian_colors.dart';
import 'package:project_tractian/widgets/shared/tractian_button.dart';
import 'package:project_tractian/widgets/shared/tractian_scaffold.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageController>(
        init: HomePageController(),
        builder: (controller) {
          return TractianScaffold(
            appBarLogoPath: 'assets/logo/logo.svg',
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 22),
              child: Obx(() {
                if (controller.enterprises.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                    itemCount: controller.enterprises.length,
                    itemBuilder: (context, index) {
                      final enterprise = controller.enterprises[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        child: TractianButton(
                          onPressed: () {
                            AppNavigator.openTreePage(
                                enterpriseModel: controller.enterprises[index]);
                          },
                          label: enterprise.name,
                          buttonType: ButtonType.large,
                          backgroundColor: TractianColor.primaryBlue,
                          textColor: TractianColor.white,
                          centerIconPath: 'assets/icons/boxes.svg',
                        ),
                      );
                    },
                  );
                }
              }),
            ),
          );
        });
  }
}
