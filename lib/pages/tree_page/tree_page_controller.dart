import 'package:get/get.dart';
import 'package:project_tractian/models/enterprise_model.dart';
import '../../repositories/general_repositorie.dart';

class TreePageController extends GetxController {
  GeneralRepository generalRepository = GeneralRepository();
  late EnterpriseModel enterpriseModel;

  var hierarchyMap = <String?, Map<String, dynamic>>{}.obs;
  var childrenVisibilityMap = <String, bool>{}.obs;
  var orderedItems = <dynamic>[].obs;
  var assetsIndex = {}.obs;

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

    // Processa localizações
    for (var location in fetchedLocations) {
      if (location.parentId == null) {
        hierarchyMap.putIfAbsent(
          location.id,
          () => {
            'location': location,
            'subLocations': [],
            'assets': [],
          },
        );
        orderedItems.add(location);
      } else {
        if (hierarchyMap.containsKey(location.parentId)) {
          hierarchyMap[location.parentId]!['subLocations'].add(location);
        } else {
          hierarchyMap[location.parentId] = {
            'location': null,
            'subLocations': [location],
            'assets': [],
          };
        }
      }
    }

    for (var asset in fetchedAssets) {
      if (hierarchyMap.containsKey(asset.locationId)) {
        hierarchyMap[asset.locationId]!['assets'].add(asset);
      } else {
        hierarchyMap[asset.locationId] = {
          'location': null,
          'subLocations': [],
          'assets': [asset],
        };
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

  int calculateDepth(dynamic item) {
    int depth = 0;
    var currentItem = item;

    while (currentItem.parentId != null) {
      depth++;
      var parentData = hierarchyMap[currentItem.parentId];
      if (parentData != null) {
        currentItem = parentData['location'];
      } else {
        break;
      }
    }

    return depth;
  }
}
