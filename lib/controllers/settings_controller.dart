import 'package:budgetplanner/utils/PreferenceUtils.dart';
import 'package:budgetplanner/utils/app_constants.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  static SettingsController get to => Get.find<SettingsController>();
  static SettingsController tagged(String name) =>
      Get.find<SettingsController>(tag: name);

  RxString langName = PreferenceUtils.getString(language, defValue: 'EN').obs;

  @override
  void onInit() {
    // TODO: implement onInit

    super.onInit();
  }
}
