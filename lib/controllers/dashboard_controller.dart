import 'package:budgetplanner/utils/PreferenceUtils.dart';
import 'package:budgetplanner/utils/app_constants.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  var currentIndex = 0.obs;
  setindex(int index) => currentIndex(index);
  var currencySymbol =
      PreferenceUtils.getString(currancy_symbol, defValue: '\u20B9').obs;
  setCurrency(String currencyName) => currencySymbol(currencyName);
  static DashboardController tagged(String name) =>
      Get.find<DashboardController>(tag: name);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
