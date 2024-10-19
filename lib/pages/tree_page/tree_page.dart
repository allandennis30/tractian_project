import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_tractian/pages/tree_page/tree_page_controller.dart';
import 'package:project_tractian/widgets/shared/tractian_scaffold.dart';
import 'node_widget.dart';

class TreePage extends StatelessWidget {
  const TreePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TreePageController>(
      init: TreePageController(),
      builder: (controller) {
        return TractianScaffold(
          onCriticalPressed: () {
            controller.filterBySensorType('alert');
          },
          onEnergySensorPressed: () {
            controller.filterBySensorType('energy');
          },
          showFilter: true,
          appBarTitle: 'Assets',
          body: Obx(() {
            var listEmpty = controller.hierarchyMap.isEmpty;
            if (listEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            final items = controller.hierarchyMap.values.toList();
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final node = items[index];
                if (node.isVisible) {
                  return NodeWidget(node: node, controller: controller);
                } else {
                  return const SizedBox.shrink();
                }
              },
            );
          }),
          onSearchChanged: (value) => controller.search(value),
        );
      },
    );
  }
}
