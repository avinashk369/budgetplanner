import 'package:budgetplanner/controllers/login_controller.dart';
import 'package:budgetplanner/controllers/test_controller.dart';
import 'package:get/instance_manager.dart';

class AllControllersBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<TestController>(() => TestController());
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<TestController>(() => TestController(), tag: "buttonEvent");
  }
}
