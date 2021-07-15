import 'package:budgetplanner/controllers/ad_controller.dart';
import 'package:budgetplanner/controllers/budget_controller.dart';
import 'package:budgetplanner/controllers/dashboard_controller.dart';
import 'package:budgetplanner/controllers/expense_controller.dart';
import 'package:budgetplanner/controllers/income_controller.dart';
import 'package:budgetplanner/controllers/login_controller.dart';
import 'package:budgetplanner/controllers/pagination_controller.dart';
import 'package:budgetplanner/controllers/saving_controller.dart';
import 'package:budgetplanner/controllers/settings_controller.dart';
import 'package:budgetplanner/controllers/test_controller.dart';
import 'package:budgetplanner/controllers/transaction_controller.dart';
import 'package:budgetplanner/utils/app_constants.dart';
import 'package:budgetplanner/utils/controller_constants.dart';
import 'package:get/instance_manager.dart';

class AllControllersBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<TestController>(() => TestController());
    Get.lazyPut<TransactionEntryController>(() => TransactionEntryController());
    Get.lazyPut<BudgetController>(() => BudgetController(),
        tag: budgetController, fenix: true);
    Get.lazyPut<BudgetController>(() => BudgetController(),
        tag: updateBudgetController, fenix: true);
    Get.lazyPut<BudgetController>(() => BudgetController());
    Get.lazyPut<IncomeController>(() => IncomeController(),
        tag: incomeController, fenix: true);
    Get.lazyPut<ExpenseController>(() => ExpenseController(),
        tag: expenseController, fenix: true);
    Get.lazyPut<SavingController>(() => SavingController(),
        tag: savingController);
    Get.lazyPut<TransactionEntryController>(() => TransactionEntryController(),
        tag: transactionEntryController);
    Get.lazyPut<TransactionEntryController>(() => TransactionEntryController(),
        tag: savingController);
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<TestController>(() => TestController(),
        tag: buttonEventController);
    Get.lazyPut<SettingsController>(() => SettingsController(), fenix: true);
    Get.lazyPut<SettingsController>(() => SettingsController(),
        tag: language, fenix: true);
    Get.lazyPut<SettingsController>(() => SettingsController(),
        tag: features, fenix: true);
    Get.lazyPut<DashboardController>(() => DashboardController(),
        tag: dashboardController, fenix: true);
    Get.lazyPut<AdController>(() => AdController(),
        tag: adController, fenix: true);
    Get.lazyPut<AdController>(() => AdController(), fenix: true);
    Get.create<AdController>(() => AdController(), tag: newAdController);
    Get.lazyPut<PaginationController>(() => PaginationController(),
        tag: paginationController, fenix: true);
  }
}
