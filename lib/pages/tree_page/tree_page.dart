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
            if (controller.orderedItems.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
              itemCount: controller.orderedItems.length,
              itemBuilder: (context, index) {
                final item = controller.orderedItems[index];
                final int depth = controller.calculateDepth(item);

                bool hasChildren = controller
                        .hierarchyMap[item.id]?['subLocations']?.isNotEmpty ??
                    false;
                bool hasAssets =
                    controller.hierarchyMap[item.id]?['assets']?.isNotEmpty ??
                        false;

                bool isChild = item.parentId != null;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (hasChildren || hasAssets) {
                          controller.toggleChildrenVisibility(item.id);
                        }
                      },
                      child: TractianTile(
                        title: item.name,
                        isChild: isChild,
                        depth: depth,
                      ),
                    ),
                    Obx(() {
                      if (controller.isChildrenVisible(item.id)) {
                        final children = controller.hierarchyMap[item.id]
                                ?['subLocations'] ??
                            [];
                        final assets =
                            controller.hierarchyMap[item.id]?['assets'] ?? [];
                        return Column(
                          children: [
                            ...children.map<Widget>((child) {
                              final int childDepth = depth + 1;
                              return GestureDetector(
                                onTap: () {
                                  if (controller
                                          .hierarchyMap[child.id]
                                              ?['subLocations']
                                          ?.isNotEmpty ??
                                      false) {
                                    controller
                                        .toggleChildrenVisibility(child.id);
                                  }
                                },
                                child: TractianTile(
                                  title: child.name,
                                  isChild: true,
                                  depth: childDepth,
                                ),
                              );
                            }).toList(),
                            ...assets.map<Widget>((asset) {
                              final int assetDepth = depth + 1;
                              return TractianTile(
                                title: asset.name,
                                isChild: true,
                                depth: assetDepth,
                              );
                            }).toList(),
                          ],
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
