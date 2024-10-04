import 'package:get/get.dart';
import 'package:project_tractian/models/enterprise_model.dart';
import 'package:project_tractian/models/location_model.dart';

import '../../repositories/general_repositorie.dart';

class TreePageController extends GetxController {
  GeneralRepository generalRepository = GeneralRepository();
  var locations = <LocationModel>[].obs;
  late EnterpriseModel enterpriseModel;

  @override
  void onInit() {
    super.onInit();
    enterpriseModel = Get.arguments as EnterpriseModel;
    getLocationsFromRepository();
  }

  void getLocationsFromRepository() async {
    var fetchedLocations =
        await generalRepository.getLocations(enterpriseModel.id);
    locations.value = fetchedLocations;
  }
}
