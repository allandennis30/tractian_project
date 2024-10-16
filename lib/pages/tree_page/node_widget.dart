import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/node_model.dart';
import 'tractian_tile.dart';
import 'tree_page_controller.dart';

class NodeWidget extends StatelessWidget {
  final NodeModel node;
  final TreePageController controller;

  const NodeWidget({required this.node, required this.controller});

  @override
  Widget build(BuildContext context) {
    bool hasChildren = node.children!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            if (hasChildren) {
              controller.toggleChildrenVisibility(node.id);
            }
          },
          child: TractianTile(
            node: node,
            parentController: controller,
          ),
        ),
        Obx(() {
          if (controller.isChildrenVisible(node.id)) {
            final children = node.children;
            return CustomScrollView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, childIndex) {
                      final child = children[childIndex];
                      return NodeWidget(node: child, controller: controller);
                    },
                    childCount: children!.length,
                  ),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        }),
      ],
    );
  }
}
