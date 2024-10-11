import 'dart:developer';
import 'package:get/get.dart';
import 'package:project_tractian/models/asset_model.dart';
import 'package:project_tractian/models/enterprise_model.dart';
import 'package:project_tractian/models/location_model.dart';
import '../../models/node_model.dart';
import '../../repositories/general_repositorie.dart';

class TreePageController extends GetxController {
  GeneralRepository generalRepository = GeneralRepository();
  late EnterpriseModel enterpriseModel;

  var hierarchyMap = <String?, NodeModel>{}.obs;
  var childrenVisibilityMap = <String, bool>{}.obs;
  var locationsIndex = <String, LocationModel>{}.obs;
  var assetsIndex = <String, AssetModel>{}.obs;

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
      locationsIndex[location.id!] = location;
    }

    for (var asset in fetchedAssets) {
      assetsIndex[asset.id] = asset;
    }

    for (var location in locationsIndex.values) {
      var node = NodeModel(
        id: location.id,
        name: location.name,
        parentId: location.parentId,
        isAsset: false,
        children: [],
      );

      if (location.parentId == null) {
        hierarchyMap.putIfAbsent(location.id, () => node);
      } else {
        if (hierarchyMap.containsKey(location.parentId)) {
          hierarchyMap[location.parentId]?.children!.add(node);
        } else {
          hierarchyMap.putIfAbsent(
              location.parentId,
              () => NodeModel(
                    id: location.parentId,
                    name: locationsIndex[location.parentId]!.name,
                    parentId: null,
                    isAsset: false,
                    children: [node],
                  ));
        }
      }
    }

    for (var asset in fetchedAssets) {
      var node = NodeModel(
        id: asset.id,
        name: asset.name,
        parentId: asset.parentId,
        isAsset: true,
        children: [],
      );

      if (asset.parentId != null && assetsIndex.containsKey(asset.parentId)) {
        var parentAsset = assetsIndex[asset.parentId]!;

        if (parentAsset.locationId != null &&
            hierarchyMap.containsKey(parentAsset.locationId)) {
          hierarchyMap[parentAsset.locationId]?.children!.add(node);
        }
      } else {
        if (asset.locationId == null) {
          hierarchyMap[asset.id] = node;
        } else if (hierarchyMap.containsKey(asset.locationId) &&
            hierarchyMap[asset.locationId] != null) {
          hierarchyMap[asset.locationId]?.children!.add(node);
        }
      }
    }

    log('complete');
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
