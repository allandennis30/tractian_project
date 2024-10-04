import 'package:get/get.dart';
import 'package:project_tractian/models/enterprise_model.dart';
import 'package:project_tractian/repositories/general_repositorie.dart';

class HomePageController extends GetxController {
  GeneralRepository generalRepository = GeneralRepository();
  var enterprises = <EnterpriseModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getEnterprisesfromRepository();
  }

  void getEnterprisesfromRepository() async {
    var fetchedEnterprises = await generalRepository.getEnterprise();
    enterprises.value = fetchedEnterprises;
  }
}
