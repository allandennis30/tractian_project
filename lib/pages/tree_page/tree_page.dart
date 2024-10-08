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
            if (controller.orderedLocations.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            return ListView.builder(
              itemCount: controller.orderedLocations.length,
              itemBuilder: (context, index) {
                final item = controller.orderedLocations[index];

                bool hasChildren =
                    (controller.locationMap[item.id] ?? []).isNotEmpty;
                bool isChild = item.parentId != null;

                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (hasChildren) {
                          controller.toggleChildrenVisibility(item.id);
                        }
                      },
                      child: TractianTile(
                        title: item.name,
                        isChild: isChild,
                      ),
                    ),
                    Obx(() {
                      if (controller.isChildrenVisible(item.id)) {
                        final children = controller.locationMap[item.id] ?? [];
                        return Column(
                          children: children.map<Widget>((child) {
                            return TractianTile(
                              title: child.name,
                              isChild: true,
                            );
                          }).toList(),
                        );
                      }
                      return Container();
                    }),
                  ],
                );
              },
            );
          }),
        );
      },
    );
  }
}
