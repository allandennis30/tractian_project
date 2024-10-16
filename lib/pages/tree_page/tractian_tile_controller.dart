import 'package:get/get.dart';

import '../../models/node_model.dart';
import 'tree_page_controller.dart';

class TractianTileController extends GetxController {
  final NodeModel node;
  final TreePageController parentController;

  final isOpen = false.obs;
  final isChild = false.obs;
  final hasChildren = false.obs;

  TractianTileController({required this.node, required this.parentController}) {
    isOpen.value = parentController.isChildrenVisible(node.id);
    isChild.value = node.parentId != null;
    hasChildren.value = node.children != null;
  }

  bool get isRootOrChildOfRoot {
    if (node.parentId == null) {
      return true;
    }
    final parentNode = parentController.nodesIndex[node.parentId];
    return parentNode?.parentId == null;
  }

  void toggleChildrenVisibility() {
    if (hasChildren.value) {
      parentController.toggleChildrenVisibility(node.id);
      isOpen.value = !isOpen.value;
    }
  }
}
