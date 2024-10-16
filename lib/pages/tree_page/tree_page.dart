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
          showFilter: true,
          appBarTitle: 'Assets',
          body: Obx(() {
            if (controller.hierarchyMap.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            final items = controller.hierarchyMap.values.toList();
            return CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final item = items[index];
                      return NodeWidget(node: item, controller: controller);
                    },
                    childCount: items.length,
                  ),
                ),
              ],
            );
          }),
        );
      },
    );
  }
}
