import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  var currentIndex = 0.obs;
  setindex(int index) => currentIndex(index);
  static DashboardController tagged(String name) =>
      Get.find<DashboardController>(tag: name);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
