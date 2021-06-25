import 'package:budgetplanner/controllers/login_controller.dart';
import 'package:budgetplanner/controllers/test_controller.dart';
import 'package:budgetplanner/controllers/transaction_controller.dart';
import 'package:budgetplanner/utils/controller_constants.dart';
import 'package:get/instance_manager.dart';

class AllControllersBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<TestController>(() => TestController());
    Get.lazyPut<TransactionEntryController>(() => TransactionEntryController());
    Get.lazyPut<TransactionEntryController>(() => TransactionEntryController(),
        tag: incomeController);
    Get.lazyPut<TransactionEntryController>(() => TransactionEntryController(),
        tag: expenseController);
    Get.lazyPut<TransactionEntryController>(() => TransactionEntryController(),
        tag: savingController);
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<TestController>(() => TestController(),
        tag: buttonEventController);
  }
}
