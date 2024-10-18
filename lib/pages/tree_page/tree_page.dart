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
            log('Energia');
          },
          onEnergySensorPressed: () {
            log('Sensor de Energia');
          },
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

/* 
class TreePage extends StatelessWidget {
  const TreePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TreePageController>(
      init: TreePageController(),
      builder: (controller) {
        return TractianScaffold(
          onCriticalPressed: () {
            log('Energia');
          },
          onEnergySensorPressed: () {
            log('Sensor de Energia');
          },
          showFilter: true,
          appBarTitle: 'Assets',
          body: Obx(() {
            if (controller.hierarchyMap.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            //final items = controller.filteredItems;
            final items = controller.hierarchyMap.values.toList();
            return ListView.builder(
                itemBuilder: (context, index) {
                  return NodeWidget(
                    node: items[index],
                    controller: controller,
                  );
                },
                itemCount: items.length);
          }),
          onSearchChanged: (value) => controller.search(value),
        );
      },
    );
  }
}
 */