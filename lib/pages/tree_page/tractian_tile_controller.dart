import 'dart:developer';

import 'package:get/get.dart';

import '../../models/node_model.dart';
import 'tree_page_controller.dart';

class TractianTileController extends GetxController {
  final NodeModel node;
  final TreePageController parentController;

  final hasChildren = false.obs;
  final isImmediateChild = false.obs;

  TractianTileController({required this.node, required this.parentController}) {
    hasChildren.value = node.children != null && node.children!.isNotEmpty;
    isImmediateChild.value = node.parentId != null &&
        parentController.nodesIndex[node.parentId]?.parentId == null;
  }

  void toggleChildrenVisibility() {
    if (hasChildren.value) {
      parentController.toggleChildrenVisibility(node.id);
    }
  }
}
