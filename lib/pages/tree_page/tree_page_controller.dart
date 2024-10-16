import 'dart:developer';
import 'package:get/get.dart';
import 'package:project_tractian/models/enterprise_model.dart';
import '../../models/node_model.dart';
import '../../repositories/general_repositorie.dart';

class TreePageController extends GetxController {
  GeneralRepository generalRepository = GeneralRepository();
  late EnterpriseModel enterpriseModel;

  var hierarchyMap = <String?, NodeModel>{}.obs;
  var childrenVisibilityMap = <String, bool>{}.obs;
  var nodesIndex = <String, NodeModel>{}.obs;

  @override
  void onInit() {
    super.onInit();
    enterpriseModel = Get.arguments as EnterpriseModel;
    fetchData();
  }

  Future<void> getLocationsAndAssets() async {
    var fetchedLocations =
        await generalRepository.getLocations(enterpriseModel.id);
    var fetchedAssets = await generalRepository.getAssets(enterpriseModel.id);

    for (var location in fetchedLocations) {
      final node = NodeModel(
        id: location.id,
        name: location.name,
        parentId: location.parentId,
        isAsset: false,
        children: [],
      );
      nodesIndex[location.id!] = node;
    }

    for (var asset in fetchedAssets) {
      final node = NodeModel(
        id: asset.id,
        name: asset.name,
        parentId: asset.parentId ?? asset.locationId,
        isAsset: true,
        locationId: asset.locationId,
        sensorType: asset.sensorType,
        status: asset.status,
        gatewayId: asset.gatewayId,
        sensorId: asset.sensorId,
        isComponent: asset.sensorType != null,
        children: [],
      );
      nodesIndex[asset.id] = node;
    }

    for (final node in nodesIndex.values) {
      addNodeToTreeBFS(node);
    }

    print('complete');
  }

  void addNodeToTreeBFS(NodeModel node) {
    final parentId = node.parentId;

    if (parentId == null) {
      hierarchyMap[node.id] = node;
    } else {
      final parentNode = nodesIndex[parentId];
      if (parentNode != null) {
        parentNode.children!.add(node);
        node.depth = (parentNode.depth) + 1;
      } else {
        hierarchyMap[node.id] = node;
      }
    }
  }

  void fetchData() async {
    await getLocationsAndAssets();
  }

  void toggleChildrenVisibility(String? parentId) {
    if (parentId == null) return;
    childrenVisibilityMap[parentId] =
        !(childrenVisibilityMap[parentId] ?? false);
  }

  bool isChildrenVisible(String? parentId) {
    return childrenVisibilityMap[parentId] ?? false;
  }

  int calculateDepth(NodeModel node) {
    int depth = 0;
    var currentItem = node;

    while (currentItem.parentId != null) {
      depth++;
      var parentData = hierarchyMap[currentItem.parentId];
      if (parentData != null) {
        currentItem = parentData;
      } else {
        break;
      }
    }

    return depth;
  }
}
