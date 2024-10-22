import 'package:get/get.dart';
import 'package:project_tractian/models/enterprise_model.dart';
import '../../models/node_model.dart';
import '../../repositories/general_repositorie.dart';

class TreePageController extends GetxController {
  GeneralRepository generalRepository = GeneralRepository();
  late EnterpriseModel enterpriseModel;
  var hierarchyMap = <String?, NodeModel>{}.obs;
  var hierarchyMapFilter = <String?, NodeModel>{}.obs;
  var swicthHierarchyMap = <String?, NodeModel>{}.obs;
  var childrenVisibilityMap = <String, bool>{}.obs;
  var nodesIndex = <String, NodeModel>{}.obs;
  var filterClicked = [].obs;
  var filterEnergy = false.obs;
  var filterCritical = false.obs;

  @override
  void onInit() {
    super.onInit();
    enterpriseModel = Get.arguments as EnterpriseModel;
    fetchData();
  }

  void search(String? query) async {
    if (query == null || query.isEmpty || query.length < 2) {
      swicthHierarchyMap = hierarchyMap;
      update();
      return;
    }
    hierarchyMapFilter.clear();
    for (var node in nodesIndex.values) {
      final nodeName = node.name?.toLowerCase() ?? '';
      if (nodeName.contains(query.toLowerCase())) {
        _filterAddNode(node);
      }
    }
    swicthHierarchyMap = hierarchyMapFilter;
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
    swicthHierarchyMap = hierarchyMap;
    update();
  }

  void filterButtonClicked(String type) {
    if (!filterClicked.contains(type)) {
      filterClicked.add(type);
    } else {
      filterClicked.remove(type);
    }

    filterCritical.value = filterClicked.contains('alert');
    filterEnergy.value = filterClicked.contains('energy');

    if (!filterEnergy.value && !filterCritical.value) {
      swicthHierarchyMap = hierarchyMap;
    } else {
      swicthHierarchyMap = hierarchyMapFilter;
      filterNodes(
        sensorType: filterEnergy.value ? 'energy' : null,
        status: filterCritical.value ? 'alert' : null,
      );
    }

    update();
  }

  void filterNodes({String? sensorType, String? status}) {
    hierarchyMapFilter.clear();
    if (sensorType == null && status == null) {}

    for (var node in nodesIndex.values) {
      if (_shouldAddNode(node, sensorType, status)) {
        _filterAddNode(node);
      }
    }
    update();
  }

  bool _shouldAddNode(NodeModel node, String? sensorType, String? status) {
    if (sensorType != null && node.sensorType != sensorType) {
      return false;
    }
    if (status != null && node.status != status) {
      return false;
    }
    return true;
  }

  void _filterAddNode(NodeModel node) {
    if (node.parentId == null && node.locationId == null) {
      node.depth = 0;
      hierarchyMap[node.id] = node;
      hierarchyMapFilter[node.id] = node;
    } else {
      final parentNode = nodesIndex[node.parentId];
      if (parentNode != null) {
        parentNode.children ??= [];
        if (parentNode.children!.contains(node) == false) {
          parentNode.children!.add(node);
          node.depth = parentNode.depth + 1;
        }
        _filterAddNode(parentNode);
        hierarchyMapFilter[node.id] = node;
      }
    }
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
