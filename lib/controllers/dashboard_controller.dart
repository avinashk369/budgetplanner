import 'package:budgetplanner/utils/PreferenceUtils.dart';
import 'package:budgetplanner/utils/app_constants.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';

class DashboardController extends GetxController {
  var currentIndex = 0.obs;
  setindex(int index) => currentIndex(index);
  var packageInfo = "".obs;
  var currencySymbol =
      PreferenceUtils.getString(currancy_symbol, defValue: '\u20B9').obs;
  setCurrency(String currencyName) => currencySymbol(currencyName);

  setPackgeInfo(String info) => packageInfo(info);
  static DashboardController tagged(String name) =>
      Get.find<DashboardController>(tag: name);

  @override
  void onInit() {
    // TODO: implement onInit
    _initPackageInfo();
    super.onInit();
  }

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setPackgeInfo(info.version);
  }
}
