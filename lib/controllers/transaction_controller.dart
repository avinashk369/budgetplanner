import 'package:budgetplanner/models/BaseModel.dart';
import 'package:budgetplanner/models/budget_category_model.dart';
import 'package:budgetplanner/models/budget_model.dart';
import 'package:budgetplanner/models/promotion_model.dart';
import 'package:budgetplanner/models/transaction_model.dart';
import 'package:budgetplanner/models/transaction_type_model.dart';
import 'package:budgetplanner/resources/firestore/dataRepositoryImpl.dart';
import 'package:budgetplanner/utils/PreferenceUtils.dart';
import 'package:budgetplanner/utils/app_constants.dart';
import 'package:budgetplanner/utils/category_constants.dart';
import 'package:budgetplanner/utils/string_constants.dart';
import 'package:budgetplanner/widgets/loading_dialog.dart';
import 'package:budgetplanner/widgets/snack_bar.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

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

  List<PromotionModel> get promotions => promotionsList.value;
  Rx<List<PromotionModel>> promotionsList = Rx<List<PromotionModel>>([]);
  setPromotions(List<PromotionModel> pmList) => promotionsList(pmList);

  List<BudgetModel> get budgetList => budgetmodel.value;
  Rx<List<BudgetModel>> budgetmodel = Rx<List<BudgetModel>>([]);

  List<BudgetModel> get monthlyBudgetList => monthlyBudgets.value;
  Rx<List<BudgetModel>> monthlyBudgets = Rx<List<BudgetModel>>([]);

  var totalExpense = 0.0.obs;
  var totalIncome = 0.0.obs;
  var totalBudget = 0.0.obs;
  setTotalExpense(double total) => totalExpense(total);
  setTotalIncome(double total) => totalIncome(total);

  var position = Offset(Get.width * .83, Get.height * .83).obs;
  setposition(Offset offset) => position(offset);
  late String userId;
  var expenseSource = "".obs;

  var nextMonth = 1.obs;
  var prevMonth = 1.obs;
  setNextMonth(int next) => nextMonth(next);
  setPrevMonth(int prev) => prevMonth(prev);

  Rx<List<String>> filterCats = Rx<List<String>>([]);
  setFiterCat(List<String> filters) => filterCats(filters);

  RxList<List<String>> piechartDataList = RxList<List<String>>([]);
  setPieChartData(List<List<String>> dataList) => piechartDataList(dataList);

  //category data set for bar chart
  List<TransactionModel> get catTransactionList => catTransactionModel.value;
  setCatTransactionList(List<TransactionModel> lists) =>
      catTransactionModel(lists);
  Rx<List<TransactionModel>> catTransactionModel =
      Rx<List<TransactionModel>>([]);
  var currencySymbol =
      PreferenceUtils.getString(currancy_symbol, defValue: '\u20B9').obs;
  @override
  void onInit() {
    // TODO: implement onInit
    userId = PreferenceUtils.getString(user_id);
    var date = DateTime.now();
    () async {
      transactionTypeList = await getTransactionTypeList();
      //bindTransaction(date);
      budgetmodel.bindStream(getBudgetListDemo(userId)!);
      totalExpense.bindStream(getTotalExpense("", userId)!);
      totalIncome.bindStream(getTotalIncome("", userId)!);
      recentTransactionModel.bindStream(getRecentTransactionList(userId)!);
      // transactionController.budgetmodel
      //     .bindStream(transactionController.getBudgetList(userId)!);
    }();
    super.onInit();
  }

  Future getMonthlyBudget() async {
    monthlyBudgets.bindStream(getMonthlyBudgetList(userId)!);
  }

  double getTotalBudget() {
    double totalBudget = 0.0;
    monthlyBudgetList.forEach((element) {
      totalBudget += element.amount!;
    });
    return totalBudget;
  }

  void bindTransaction(DateTime date, String expenseSource) {
    transactionModel.bindStream(getTransactionList(
        userId, expense, date, filterCats.value, expenseSource)!);
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

/**
 * get all the transaction of the year
 */
  Future<List<TransactionModel>?> getAllTransactionOfYear(int year) async {
    try {
      return await DataRepositoryImpl()
          .getAllTransactionsOfYear(userId, year, '');
    } catch (e) {}
  }

/**
 * get all the transaction of the year for category
 */
  Future<List<TransactionModel>?> getAllTransactionOfYearForCategory(
      int year, String catName) async {
    try {
      return await DataRepositoryImpl()
          .getAllTransactionsOfYear(userId, year, catName);
    } catch (e) {}
  }

  /**
   * categorised data for pie chart and list view
   */
  List<List<String>> generateCategoryMap(
      List<TransactionModel> trxList, String trxType) {
    var newMap1 =
        groupBy(trxList, (TransactionModel model) => model.transactionType);
    List<List<String>> dataList = [];
    newMap1.forEach((key, value) {
      print(key);
      if (key == trxType) {
        var newMap = groupBy(value, (TransactionModel model) => model.catName);

        newMap.forEach((key, value) {
          //print(key);
          double amount = 0;
          int totalCount = 0;

          value.forEach((element) {
            if (element.transactionType == trxType) {
              amount += element.amount!;
              totalCount++;
            }
          });
          dataList.add([key!, amount.toString(), totalCount.toString()]);
        });
      }
    });
    return dataList;
  }

  /**
   * get data list for bar chart
   */
  Map<String, List<double>> getDataListForBarchart(
      List<TransactionModel> transactionList) {
    var newMap = groupBy(transactionList,
        (TransactionModel model) => model.createdOn.toString().substring(5, 7));
    //validate new map
    Map<String, List<double>> dataList = {};
    newMap.forEach((key, value) {
      //print(key);
      double incomeAmount = 0;
      double expenseAmount = 0;

      value.forEach((element) {
        switch (element.transactionType) {
          case income:
            incomeAmount += element.amount!;
            break;
          case expense:
            expenseAmount += element.amount!;
            break;
        }
      });
      dataList[key] = [
        incomeAmount,
        expenseAmount,
        incomeAmount - expenseAmount
      ];
    });
    return dataList;
  }

  /**
   * get data list for category bar chart
   */
  Map<String, List<double>> getDataListForCatBarchart(
      List<TransactionModel> transactionList) {
    var newMap = groupBy(transactionList,
        (TransactionModel model) => model.createdOn.toString().substring(5, 7));
    //validate new map
    Map<String, List<double>> dataList = {};
    newMap.forEach((key, value) {
      double expenseAmount = 0;

      value.forEach((element) {
        switch (element.transactionType) {
          case expense:
            expenseAmount += element.amount!;
            break;
          case income:
            expenseAmount += element.amount!;
            break;
        }
      });
      dataList[key] = [
        expenseAmount,
      ];
    });
    return dataList;
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

      Get.showSnackbar(SnackBarDialog.getSnanck(
              lbl_budget_delete_success.tr, transactionTab.tr))
          .future;
      Navigator.of(keyLoader.currentContext!, rootNavigator: true).pop();
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
    } catch (e) {
    } finally {
      isLoading(false);
    }

    return incomeCategories!.data!;
  }

  Stream<List<TransactionModel>>? getTransactionList(
    String userId,
    String transactionType,
    DateTime currenctMonth,
    List<String> filterCategory,
    String expenseSource,
  ) {
    BaseModel<List<TransactionModel>>? transactionList;
    try {
      isLoading(true);
      return DataRepositoryImpl().getTransactions(userId, transactionType,
          currenctMonth, filterCategory, expenseSource);
    } catch (e) {
    } finally {
      isLoading(false);
    }
  }

  Stream<List<TransactionModel>>? getRecentTransactionList(String userId) {
    try {
      isLoading(true);
      return DataRepositoryImpl().getRecentTransactions(userId);
    } catch (e) {
    } finally {
      isLoading(false);
    }
  }

  Stream<List<BudgetModel>>? getBudgetList(String userId) {
    try {
      isLoading(true);
      return DataRepositoryImpl().getBudgetList(userId);
    } catch (e) {
    } finally {
      isLoading(false);
    }
  }

  //get monthly budget
  Stream<List<BudgetModel>>? getMonthlyBudgetList(String userId) {
    try {
      isLoading(true);
      return DataRepositoryImpl().getMonthlyBudget(userId);
    } catch (e) {
    } finally {
      isLoading(false);
    }
  }

  Stream<List<BudgetModel>>? getBudgetListDemo(String userId) {
    try {
      isLoading(true);
      return DataRepositoryImpl().listAllBudget(userId);
    } catch (e) {
    } finally {
      isLoading(false);
    }
  }

  Stream<double>? getTotalExpense(String monthName, String userId) {
    try {
      isLoading(true);
      print("Going to get total expense record");
      return DataRepositoryImpl().getTotalExpense(monthName, userId);
    } catch (e) {
    } finally {
      isLoading(false);
    }
  }

  Stream<double>? getTotalIncome(String monthName, String userId) {
    try {
      isLoading(true);
      print("Going to get total expense record");
      return DataRepositoryImpl().getTotalIncome(monthName, userId);
    } catch (e) {
    } finally {
      isLoading(false);
    }
  }

  /**
   * check storage permission
   */
  Future<void> _checkPermission(BuildContext context) async {
    final serviceStatus = await Permission.storage.status;
    final isGpsOn = serviceStatus.isGranted;
    if (!isGpsOn) {
      print('Turn on location services before requesting permission.');
      return;
    }

    final status = await Permission.storage.request();
    if (status == PermissionStatus.granted) {
      print('Permission granted');
    } else if (status == PermissionStatus.denied) {
      print(
          'Permission denied. Show a dialog and again ask for the permission');
    } else if (status == PermissionStatus.permanentlyDenied) {
      print('Take the user to the settings page.');
      showDialog(
          context: context,
          builder: (BuildContext context) => CupertinoAlertDialog(
                title: Text('Storage Permission'),
                content: Text(
                    'This app needs storage access to download report files'),
                actions: <Widget>[
                  CupertinoDialogAction(
                    child: Text('Deny'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  CupertinoDialogAction(
                    child: Text('Settings'),
                    onPressed: () async => await openAppSettings(),
                  ),
                ],
              ));
    }
  }

  /**
   * download report
   */
  Future getTransactions(
      BuildContext context, List<TransactionModel> transactionList) async {
    _checkPermission(context);
    try {
      LoadingDialog.showLoadingDialog(context, keyLoader);
      BaseModel<List<BudgetCategoryModel>> listData =
          await DataRepositoryImpl().getBudgetCategories();
      List<List<String>> dataList = [];
      dataList.add([
        "No.",
        "Amount",
        "Category",
        "Expense Source",
        "Transaction Type",
        "Notes",
        "Transaction Date"
      ]);
      int i = 1;
      transactionList.forEach((element) {
        dataList.add([
          "$i",
          "${element.amount}",
          "${element.catName}",
          "${element.expenseSource}",
          "${element.transactionType}",
          "${element.notes}",
          "${element.createdOn!.toIso8601String().substring(0, 10)}"
        ]);
        i++;
      });

      await DataRepositoryImpl().generateCsv(dataList);
    } catch (e) {
      Navigator.of(keyLoader.currentContext!, rootNavigator: true).pop();
      print(e.toString());
    } finally {
      Navigator.of(keyLoader.currentContext!, rootNavigator: true).pop();
    }
  }

  /**
   * fliter transactionList 
   */
  Stream<List<TransactionModel>>? filterTransactionList(
      List<TransactionModel> complteList, String filterName) async* {
    try {
      isLoading(true);
      var kList = complteList.map((e) {
        if (e.expenseSource == filterName) {
          return e;
        }
      }).toList();
      List<TransactionModel> testList = [];
      kList.forEach((element) {
        if (element != null) {
          testList.add(element);
          print("$filterName avinash ${element.catName}");
        }
      });

      print("avinash ${testList.length}");
      yield testList;
    } catch (e) {
    } finally {
      isLoading(false);
    }
  }

  Stream<List<PromotionModel>>? getAlPromotions() {
    try {
      isLoading(true);
      return DataRepositoryImpl().getAllPromotions();
    } catch (e) {
    } finally {
      isLoading(false);
    }
  }
}
