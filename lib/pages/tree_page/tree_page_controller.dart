import 'package:get/get.dart';
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
  }

  void getLocationsFromRepository() async {
    var fetchedLocations =
        await generalRepository.getLocations(enterpriseModel.id);

    Map<String?, List<LocationModel>> groupedLocations = {};
    for (var location in fetchedLocations) {
      groupedLocations[location.id] = [location];
      if (groupedLocations.containsKey(location.id)) {
        groupedLocations[location.parentId]!.add(location);
      }
    }
    locationsByParent.value = groupedLocations;
  }
}
