import 'package:budgetplanner/models/BaseModel.dart';
import 'package:budgetplanner/models/budget_model.dart';
import 'package:budgetplanner/models/transaction_model.dart';
import 'package:budgetplanner/models/transaction_type_model.dart';
import 'package:budgetplanner/resources/firestore/dataRepositoryImpl.dart';
import 'package:budgetplanner/utils/PreferenceUtils.dart';
import 'package:budgetplanner/utils/app_constants.dart';
import 'package:budgetplanner/utils/category_constants.dart';
import 'package:budgetplanner/utils/string_constants.dart';
import 'package:budgetplanner/widgets/loading_dialog.dart';
import 'package:budgetplanner/widgets/snack_bar.dart';
import 'package:budgetplanner/widgets/theme_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionEntryController extends GetxController {
  late List<TransactionType> transactionTypeList;
  var isLoading = true.obs;
  static TransactionEntryController get to =>
      Get.find<TransactionEntryController>();

  final GlobalKey<State> keyLoader = new GlobalKey<State>();
  List<TransactionModel> get transactionList => transactionModel.value;

  Rx<List<TransactionModel>> transactionModel = Rx<List<TransactionModel>>([]);

  List<TransactionModel> get recentTransactionList =>
      recentTransactionModel.value;
  Rx<List<TransactionModel>> recentTransactionModel =
      Rx<List<TransactionModel>>([]);

  List<BudgetModel> get budgetList => budgetmodel.value;
  Rx<List<BudgetModel>> budgetmodel = Rx<List<BudgetModel>>([]);
  var totalExpense = 0.0.obs;
  var totalIncome = 0.0.obs;
  setTotalExpense(double total) => totalExpense(total);
  setTotalIncome(double total) => totalIncome(total);

  var position = Offset(Get.width * .83, Get.height * .83).obs;
  setposition(Offset offset) => position(offset);
  late String userId;
  @override
  void onInit() {
    // TODO: implement onInit
    userId = PreferenceUtils.getString(user_id);
    () async {
      transactionTypeList = await getTransactionTypeList();
      transactionModel.bindStream(getTransactionList(userId, expense)!);
      budgetmodel.bindStream(getBudgetListDemo(userId)!);
      totalExpense.bindStream(getTotalExpense("", userId)!);
      totalIncome.bindStream(getTotalIncome("", userId)!);
      recentTransactionModel.bindStream(getRecentTransactionList(userId)!);
      // transactionController.budgetmodel
      //     .bindStream(transactionController.getBudgetList(userId)!);
    }();
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  Future deletetransaction(BuildContext context, String id) async {
    try {
      isLoading(true);
      LoadingDialog.showLoadingDialog(context, keyLoader);
      await DataRepositoryImpl().deleteTransaction(id);
    } catch (e) {
      Navigator.of(keyLoader.currentContext!, rootNavigator: true).pop();
      SnackBarDialog.displaySnackbar(
        transactionTab.tr,
        lbl_trx_not_delete.tr,
      );
    } finally {
      isLoading(false);
      Navigator.of(keyLoader.currentContext!, rootNavigator: true).pop();

      Get.showSnackbar(SnackBarDialog.getSnanck(
              lbl_budget_delete_success.tr, transactionTab.tr))!
          .whenComplete(() => Get.back(
                canPop: true,
              ));
    }
  }

  void updatetransaction(TransactionModel transactionModel) async {
    try {
      isLoading(true);
      await DataRepositoryImpl().updateTransaction(transactionModel);
    } catch (e) {
      SnackBarDialog.displaySnackbar(
        transactionTab.tr,
        lbl_trx_not_updated.tr,
      );
    } finally {
      isLoading(false);
      SnackBarDialog.displaySuccessSnackbar(
        transactionTab.tr,
        lbl_trx_updated.tr,
      );
    }
  }

  Future<List<TransactionType>> getTransactionTypeList() async {
    BaseModel<List<TransactionType>>? incomeCategories;
    try {
      isLoading(true);
      incomeCategories = await DataRepositoryImpl().getTransactionType();
    } catch (e) {} finally {
      isLoading(false);
    }

    return incomeCategories!.data!;
  }

  Stream<List<TransactionModel>>? getTransactionList(
      String userId, String transactionType) {
    BaseModel<List<TransactionModel>>? transactionList;
    try {
      isLoading(true);
      return DataRepositoryImpl().getTransactions(userId, transactionType);
    } catch (e) {} finally {
      isLoading(false);
    }
  }

  Stream<List<TransactionModel>>? getRecentTransactionList(String userId) {
    try {
      isLoading(true);
      return DataRepositoryImpl().getRecentTransactions(userId);
    } catch (e) {} finally {
      isLoading(false);
    }
  }

  Stream<List<BudgetModel>>? getBudgetList(String userId) {
    try {
      isLoading(true);
      return DataRepositoryImpl().getBudgetList(userId);
    } catch (e) {} finally {
      isLoading(false);
    }
  }

  Stream<List<BudgetModel>>? getBudgetListDemo(String userId) {
    try {
      isLoading(true);
      return DataRepositoryImpl().listAllBudget(userId);
    } catch (e) {} finally {
      isLoading(false);
    }
  }

  Stream<double>? getTotalExpense(String monthName, String userId) {
    try {
      isLoading(true);
      print("Going to get total expense record");
      return DataRepositoryImpl().getTotalExpense(monthName, userId);
    } catch (e) {} finally {
      isLoading(false);
    }
  }

  Stream<double>? getTotalIncome(String monthName, String userId) {
    try {
      isLoading(true);
      print("Going to get total expense record");
      return DataRepositoryImpl().getTotalIncome(monthName, userId);
    } catch (e) {} finally {
      isLoading(false);
    }
  }

  void checkLogin(BuildContext context) {
    // final isValid = incomeKey.currentState!.validate();
    // if (!isValid) {
    //   return;
    // }
    // LoadingDialog.showLoadingDialog(context, _keyLoader);
    // Authentication.signinWithEmailPassword(
    //   context: context,
    //   email: emailController.text.toString(),
    //   password: "password",
    // ).then((value) {
    //   print("${value!.uid} registerd user id ${value.emailVerified}");
    //   Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
    // if (!value.emailVerified) {
    //   Get.dialog(
    //     MyAlertDialog(
    //       title: Container(),
    //       content: Text('verification-email-sent-message'.tr),
    //       actions: [
    //         TextButton(
    //           onPressed: () => Get.back(),
    //           child: Text(
    //             'Ok',
    //             style: TextStyle(
    //               color: Color(0xFF39bc26),
    //             ),
    //           ),
    //         )
    //       ],
    //     ),
    //   );
    // } else {
    //Navigator.popAndPushNamed(context, dashboardRoute);
    //}
    //});
  }
}
