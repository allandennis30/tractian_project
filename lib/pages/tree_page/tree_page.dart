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
            return ListView.builder(
              itemCount: controller.hierarchyMap.length,
              itemBuilder: (context, index) {
                final item = controller.hierarchyMap[index];
                final int depth = controller.calculateDepth(item!);
                bool hasChildren =
                    controller.hierarchyMap[item.id]?.children?.isNotEmpty ??
                        false;

                bool hasAssets = controller.hierarchyMap[item.id]?.children!
                        .any((child) => child.isAsset) ??
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
                        // Obtenha todos os filhos (tanto subLocalizações quanto ativos)
                        final children =
                            controller.hierarchyMap[item.id]?.children ?? [];

                        return Column(
                          children: children.map<Widget>((child) {
                            final int childDepth = depth + 1;

                            // Verifica se o nó filho tem mais filhos
                            bool hasChildren =
                                child.children?.isNotEmpty ?? false;

                            return GestureDetector(
                              onTap: () {
                                if (hasChildren) {
                                  controller.toggleChildrenVisibility(child.id);
                                }
                              },
                              child: TractianTile(
                                title: child.name,
                                isChild: true,
                                depth: childDepth,
                              ),
                            );
                          }).toList(),
                        );
                      }
                      return const SizedBox
                          .shrink(); // Evita retornar um Container vazio
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
