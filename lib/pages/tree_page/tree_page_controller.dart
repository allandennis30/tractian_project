import 'package:get/get.dart';
import 'package:project_tractian/models/enterprise_model.dart';
import '../../repositories/general_repositorie.dart';

class TreePageController extends GetxController {
  GeneralRepository generalRepository = GeneralRepository();
  late EnterpriseModel enterpriseModel;

  var hierarchyMap = <String?, List<dynamic>>{}.obs;
  var locationMap = <String?, List<dynamic>>{}.obs;
  var orderedLocations = <dynamic>[].obs;
  var childrenVisibilityMap = <String, bool>{}.obs;

  @override
  void onInit() {
    super.onInit();
    enterpriseModel = Get.arguments as EnterpriseModel;
    fetchData();
  }

  void fetchData() async {
    await getLocationsFromRepository();
  }

  void toggleChildrenVisibility(String? parentId) {
    if (parentId == null) return;
    childrenVisibilityMap[parentId] =
        !(childrenVisibilityMap[parentId] ?? false);
  }

  bool isChildrenVisible(String? parentId) {
    return childrenVisibilityMap[parentId] ?? false;
  }

  Future<void> getLocationsFromRepository() async {
    var fetchedLocations =
        await generalRepository.getLocations(enterpriseModel.id);

    fetchedLocations.sort((a, b) {
      if (a.parentId == null) return -1;
      if (b.parentId == null) return 1;
      return 0;
    });

    for (var location in fetchedLocations) {
      locationMap[location.id] = [location];

      orderedLocations.add(location);

      if (location.parentId != null && location.parentId != location.id) {
        locationMap[location.parentId] = locationMap[location.parentId] ?? [];
        locationMap[location.parentId]!.add(location);
      }
    }
  }

  Future<void> getAssets() async {
    var fetchedAssets = await generalRepository.getAssets(enterpriseModel.id);

    for (var asset in fetchedAssets) {
      hierarchyMap[asset.id] = [asset];

      if (asset.parentId != null) {
        hierarchyMap[asset.parentId] = hierarchyMap[asset.parentId] ?? [];
        hierarchyMap[asset.parentId]!.add(asset);
      }
    }
  }
}


/* import 'package:get/get.dart';
import 'package:project_tractian/models/asset_model.dart';
import 'package:project_tractian/models/enterprise_model.dart';
import 'package:project_tractian/models/location_model.dart';

import '../../repositories/general_repositorie.dart';

class TreePageController extends GetxController {
  GeneralRepository generalRepository = GeneralRepository();
  late EnterpriseModel enterpriseModel;
  var locationsByParent = <String?, List<LocationModel>>{}.obs;

  @override
  void onInit() {
    super.onInit();
    enterpriseModel = Get.arguments as EnterpriseModel;
    getLocationsFromRepository();
    getAssets();
  }

  void getLocationsFromRepository() async {
    var fetchedLocations =
        await generalRepository.getLocations(enterpriseModel.id);

    Map<String?, List<LocationModel>> groupedLocations = {};
    for (var location in fetchedLocations) {
      groupedLocations[location.id] = [location];
      if (groupedLocations.containsKey(location.parentId)) {
        groupedLocations[location.parentId]!.add(location);
      }
    }
    locationsByParent.value = groupedLocations;
  }

  void getAssets() async {
    var fetchedAssets = await generalRepository.getAssets(enterpriseModel.id);
    Map<String?, List<AssetModel>> groupedAssets = {};
    for (var asset in fetchedAssets) {
      groupedAssets[asset.id] = [asset];
      if (groupedAssets.containsKey(asset.parentId)) {
        groupedAssets[asset.parentId]!.add(asset);
      }
    }
  }
}
 */