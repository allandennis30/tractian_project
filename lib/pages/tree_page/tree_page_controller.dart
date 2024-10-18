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

  void search(String? query) async {
    await Future.delayed(const Duration(seconds: 1));
    final trimmedQuery = query?.toLowerCase() ?? '';

    void updateVisibility(NodeModel node) {
      bool isVisible = node.name?.toLowerCase().contains(trimmedQuery) == true;
      node.isVisible = isVisible;

      if (!isVisible && node.children != null) {
        for (var child in node.children!) {
          updateVisibility(child);
        }
      }

      if (!isVisible &&
          node.children != null &&
          node.children!.any((child) => child.isVisible)) {
        node.isVisible = true;
        makeChildrenVisibility(node.id);
      }
    }

    hierarchyMap.forEach((key, node) {
      updateVisibility(node);
    });

    update();
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
          isVisible: true);
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
          isVisible: true);
      nodesIndex[asset.id] = node;
    }

    for (final node in nodesIndex.values) {
      addNodeToTreeBFS(node);
    }
    update();
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
        node.depth = parentNode.depth + 1;
        _adjustChildrenDepth(node);
      } else {
        hierarchyMap[node.id] = node;
      }
    }
  }

  void _adjustChildrenDepth(NodeModel node) {
    for (var child in node.children!) {
      child.depth = node.depth + 1;
      _adjustChildrenDepth(child);
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

  void makeChildrenVisibility(String? parentId) {
    if (parentId == null) return;
    childrenVisibilityMap[parentId] = true;
  }

  bool isChildrenVisible(String? parentId) {
    if (parentId == null) return false;
    return childrenVisibilityMap[parentId] ?? false;
  }
}


/* 
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
    /* fetchData().then((_) {
      filteredItems.value = hierarchyMap.values.toList();
     });*/
  }

  void search(String? query) {
    final trimmedQuery = query?.toLowerCase() ?? '';
    hierarchyMap.forEach((key, node) {
      if (node.name?.toLowerCase().contains(trimmedQuery) == true) {
        node.isVisible = true;
        childrenVisibilityMap[key!] = true;
      } else {
        node.isVisible = false;
      }
    });
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
          isVisible: true);
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
          isVisible: true);
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
        node.depth = parentNode.depth + 1;
        _adjustChildrenDepth(node);
      } else {
        hierarchyMap[node.id] = node;
      }
    }
  }

  void _adjustChildrenDepth(NodeModel node) {
    for (var child in node.children!) {
      child.depth = node.depth + 1;
      _adjustChildrenDepth(child);
    }
  }

  fetchData() async {
    await getLocationsAndAssets();
  }

  void toggleChildrenVisibility(String? parentId) {
    if (parentId == null) return;
    childrenVisibilityMap[parentId] =
        !(childrenVisibilityMap[parentId] ?? false);
  }

  bool isChildrenVisible(String? parentId) {
    if (parentId == null) return false;
    return childrenVisibilityMap[parentId] ?? false;
  }
}
 */