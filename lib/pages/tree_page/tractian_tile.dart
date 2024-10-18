import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_tractian/models/node_model.dart';
import 'package:project_tractian/theme/tractian_colors.dart';
import 'package:project_tractian/widgets/shared/tractian_line_painter.dart';
import 'package:project_tractian/widgets/tractian_icons_provider.dart';

import 'tractian_tile_controller.dart';
import 'tree_page_controller.dart';

class TractianTile extends StatelessWidget {
  final NodeModel node;
  final TreePageController parentController;

  const TractianTile({super.key, required this.node, required this.parentController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TractianTileController>(
      init: TractianTileController(
          node: node, parentController: parentController),
      builder: (ctrl) {
        return Obx(() {
          var hasChildren = node.children != null && node.children!.isNotEmpty;
          var isOpen = parentController.isChildrenVisible(node.id);
          var isSensor = node.sensorId != null;
          var isRoot = node.parentId == null;

          return Container(
            color: TractianColor.white,
            padding: const EdgeInsets.only(
              left: 12,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (!isRoot)
                  Padding(
                    padding: const EdgeInsets.only(left: 11),
                    child: CustomPaint(
                      size: const Size(2, 30),
                      painter: TractianLinePainter(
                        lineType: LineType.fullHeightVertical,
                      ),
                    ),
                  ),
                SizedBox(width: node.depth.toDouble() * 18),
                if (isSensor) SizedBox(width: node.depth.toDouble() * 8),
                if (!isSensor)
                  Column(
                    children: [
                      Icon(
                        hasChildren
                            ? (isOpen ? Icons.expand_less : Icons.expand_more)
                            : Icons.expand_less,
                      ),
                    /*   CustomPaint(
                        size: const Size(0, 6),
                        painter: TractianLinePainter(
                            lineType: LineType.fullHeightVertical),
                      ), */
                    ],
                  ),
                const SizedBox(width: 10.0),
                TractianIconProvider.getIcon(
                  node.isComponent
                      ? 'component'
                      : node.isAsset
                          ? 'asset'
                          : 'local',
                )?? const SizedBox.shrink(),
                const SizedBox(width: 10.0),
                Flexible(
                  child: Text(
                    node.name!,
                    style: const TextStyle(fontSize: 18),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 10.0),
               TractianIconProvider.getIcon(
  node.sensorType == 'energy'
      ? 'energy'
      : node.status == 'alert'
          ? 'alert'
          : null,
) ?? const SizedBox.shrink(),

              ],
            ),
          );
        });
      },
    );
  }
}
