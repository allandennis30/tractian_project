import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_tractian/pages/tree_page/tree_page_controller.dart';
import 'package:project_tractian/widgets/shared/tractian_scaffold.dart';

import '../../widgets/shared/tractian_tile.dart';

class TreePage extends StatelessWidget {
  const TreePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TreePageController>(
      init: TreePageController(),
      builder: (controller) {
        return TractianScaffold(
          showFilter: true,
          appBarTitle: 'Assets',
          body: Obx(() {
            if (controller.locationsByParent.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            final parentIds = controller.locationsByParent.keys.toList();

            return ListView.builder(
              itemCount: parentIds.length,
              itemBuilder: (context, index) {
                final parentId = parentIds[index];
                final locations = controller.locationsByParent[parentId]!;

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TractianTile(
                    title: locations.first.name,
                    isChild: locations.first.parentId != null,
                  ),
                );
              },
            );
          }),
        );
      },
    );
  }
}
