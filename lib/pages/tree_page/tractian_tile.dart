import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_tractian/models/node_model.dart';
import 'package:project_tractian/theme/tractian_colors.dart';
import 'package:project_tractian/widgets/tractian_icons_provider.dart';

import 'tractian_tile_controller.dart';
import 'tree_page_controller.dart';

class TractianTile extends StatelessWidget {
  final NodeModel node;
  final TreePageController parentController;

  TractianTile({required this.node, required this.parentController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TractianTileController>(
      init: TractianTileController(
          node: node, parentController: parentController),
      builder: (ctrl) {
        return Obx(() {
          var hasChildren = node.children != null;
          var isOpen = parentController.isChildrenVisible(node.id);
          var isChild = ctrl.isChild.value;
          var isSensor = node.sensorId != null;

          return Container(
            color: TractianColor.white,
            padding: EdgeInsets.only(
              left: 12,
              top: 6,
              bottom: 6.0,
            ),
            child: Row(
              children: [
                isSensor
                    ? const SizedBox.shrink()
                    : Icon(
                        hasChildren
                            ? (isOpen ? Icons.expand_less : Icons.expand_more)
                            : Icons.expand_less,
                      ),
                TractianIconProvider.getIcon(
                  node.isComponent
                      ? 'component'
                      : node.isAsset
                          ? 'asset'
                          : 'local',
                ),
                const SizedBox(width: 10.0),
                Text(node.name!, style: const TextStyle(fontSize: 18)),
                const SizedBox(width: 10.0),
                TractianIconProvider.getIcon(
                  node.sensorType == 'energy'
                      ? 'energy'
                      : node.status == 'alert'
                          ? 'alert'
                          : 'inactive',
                ),
              ],
            ),
          );
        });
      },
    );
  }
}
