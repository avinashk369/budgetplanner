import 'package:budgetplanner/controllers/budget_controller.dart';
import 'package:budgetplanner/controllers/expense_controller.dart';
import 'package:budgetplanner/controllers/income_controller.dart';
import 'package:budgetplanner/controllers/login_controller.dart';
import 'package:budgetplanner/controllers/saving_controller.dart';
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
    Get.lazyPut<BudgetController>(() => BudgetController(),
        tag: budgetController);
    Get.lazyPut<BudgetController>(() => BudgetController());
    Get.lazyPut<IncomeController>(() => IncomeController(),
        tag: incomeController, fenix: true);
    Get.lazyPut<ExpenseController>(() => ExpenseController(),
        tag: expenseController, fenix: true);
    Get.lazyPut<SavingController>(() => SavingController(),
        tag: savingController);
    Get.lazyPut<TransactionEntryController>(() => TransactionEntryController(),
        tag: expenseController);
    Get.lazyPut<TransactionEntryController>(() => TransactionEntryController(),
        tag: savingController);
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<TestController>(() => TestController(),
        tag: buttonEventController);
  }
}
