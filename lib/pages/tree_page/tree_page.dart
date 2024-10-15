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
            if (controller.hierarchyMap.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            final items = controller.hierarchyMap.values.toList();

            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                bool hasChildren = item.children?.isNotEmpty ?? false;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (hasChildren) {
                          controller.toggleChildrenVisibility(item.id);
                        }
                      },
                      child: TractianTile(
                        title: item.name,
                        isChild: item.parentId != null,
                        depth: item.depth,
                      ),
                    ),
                    Obx(() {
                      if (controller.isChildrenVisible(item.id)) {
                        final children = item.children ?? [];

                        return ListView.builder(
                          itemCount: children.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, childIndex) {
                            final child = children[childIndex];
                            final int childDepth = item.depth + 1;
                            bool childHasChildren =
                                child.children?.isNotEmpty ?? false;

                            return GestureDetector(
                              onTap: () {
                                if (childHasChildren) {
                                  controller.toggleChildrenVisibility(child.id);
                                }
                              },
                              child: TractianTile(
                                title: child.name,
                                isChild: true,
                                depth: childDepth,
                              ),
                            );
                          },
                        );
                      }
                      return const SizedBox.shrink();
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
