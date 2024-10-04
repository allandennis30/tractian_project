import 'package:get/get.dart';
import 'package:project_tractian/models/enterprise_model.dart';
import 'package:project_tractian/repositories/enterprise_repositorie.dart';

class HomePageController extends GetxController {
  EnterpriseRepository enterpriseRepository = EnterpriseRepository();
  var enterprises = <EnterpriseModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getEnterprisesfromRepository();
  }

  void getEnterprisesfromRepository() async {
    var fetchedEnterprises = await enterpriseRepository.getEnterprise();
    enterprises.value = fetchedEnterprises;
  }
}
