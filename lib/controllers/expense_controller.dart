import 'package:budgetplanner/controllers/base_controller.dart';
import 'package:budgetplanner/controllers/transaction_controller.dart';
import 'package:budgetplanner/models/BaseModel.dart';
import 'package:budgetplanner/models/budget_category_model.dart';
import 'package:budgetplanner/models/expense_source_model.dart';
import 'package:budgetplanner/models/income_model.dart';
import 'package:budgetplanner/models/recurrance_model.dart';
import 'package:budgetplanner/models/transaction_model.dart';
import 'package:budgetplanner/resources/firestore/dataRepositoryImpl.dart';
import 'package:budgetplanner/utils/PreferenceUtils.dart';
import 'package:budgetplanner/utils/app_constants.dart';
import 'package:budgetplanner/utils/category_constants.dart';
import 'package:budgetplanner/utils/string_constants.dart';
import 'package:budgetplanner/widgets/_ModalBottomSheetLayout.dart';
import 'package:budgetplanner/widgets/expense_source_list.dart';
import 'package:budgetplanner/widgets/loading_dialog.dart';
import 'package:budgetplanner/widgets/loading_ui.dart';
import 'package:budgetplanner/widgets/recurrance_list.dart';
import 'package:budgetplanner/widgets/snack_bar.dart';
import 'package:budgetplanner/widgets/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpenseController extends BaseController {
  var isLoading = true.obs;
  var isWant = false.obs;
  var isNeed = false.obs;
  var isRecurring = false.obs;
  final GlobalKey<FormState> expenseKey = GlobalKey<FormState>();
  final GlobalKey<State> keyLoader = new GlobalKey<State>();
  late TextEditingController amountController, notesController;
  late List<BudgetCategoryModel> catList;
  late List<ExpenseSourceModel> expenseSourceList;

  late List<RecurranceModel> recurranceList;
  var expenseSourceModel = ExpenseSourceModel().obs;

  var budgetCatModel = BudgetCategoryModel().obs;
  var recurranceModel = RecurranceModel().obs;
  final controller = TransactionEntryController.to;
  setExpenseSource(ExpenseSourceModel expenseSource) =>
      expenseSourceModel(expenseSource);
  setExpenseMode(BudgetCategoryModel budgetCategoryModel) =>
      budgetCatModel(budgetCategoryModel);
  setRecurranceModeel(RecurranceModel recurrance) =>
      recurranceModel(recurrance);
  static ExpenseController get to => Get.find<ExpenseController>();
  static ExpenseController tagged(String name) =>
      Get.find<ExpenseController>(tag: name);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    amountController = TextEditingController(text: "100");
    notesController = TextEditingController(text: "test transaction");
    () async {
      catList = await getBudgetCategories();
      recurranceList = await getRecurranceList();
      expenseSourceList = await getExpenseSourceList();
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
    amountController.dispose();
    notesController.dispose();
  }

  String? validateAmount(String amount) {
    if (amount.length < 1) {
      return "Please enter email";
    }
    return null;
  }

  String? validatePassword(String password) {
    if (password.length <= 6) {
      return "Password must be of 6 characters";
    }
    return null;
  }

  void submitIncomeRecord(BuildContext context) async {
    final isValid = expenseKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    if (GetUtils.isNull(budgetCatModel.value.name)) {
      print("Please select income");
      SnackBarDialog.displaySnackbar(
        "Expense",
        "Please select expense source",
      );

      return;
    }
    if (recurranceModel.value.name == null) print("Please select recurrance");
    if (expenseKey.currentState!.validate()) {
      // print(amountController.text);
      // print(notesController.text);
      // print(recurranceModel.value.name ?? recurrance);
      // print(budgetCatModel.value.name);
      try {
        isLoading(true);
        LoadingDialog.showLoadingDialog(context, keyLoader);
        TransactionModel transactionModel = TransactionModel();
        transactionModel.amount = double.parse(amountController.text);
        transactionModel.notes = notesController.text;
        transactionModel.catName = budgetCatModel.value.name;
        transactionModel.transactionType = expense;
        transactionModel.expenseType = (isWant()) ? want : need;
        transactionModel.isRecurring = isRecurring();
        transactionModel.expenseSource =
            expenseSourceModel.value.name ?? def_source;
        transactionModel.createdOn = DateTime.now();
        transactionModel.recurrance =
            recurranceModel.value.name ?? def_recurrance;
        transactionModel.userId = PreferenceUtils.getString(user_id);
        await DataRepositoryImpl().saveTransaction(transactionModel);
      } catch (e) {
        Navigator.of(keyLoader.currentContext!, rootNavigator: true).pop();
        SnackBarDialog.displaySnackbar(
          "Transaction",
          "Ooops!!!...transaction cancelled!",
        );
      } finally {
        isLoading(false);
        Navigator.of(keyLoader.currentContext!, rootNavigator: true).pop();
        SnackBarDialog.displaySuccessSnackbar(
          "Transaction",
          "Transaction completed successfully!",
        );
      }
    }

    Future.delayed(Duration(seconds: 3), () async {});
  }

  Future<List<BudgetCategoryModel>> getBudgetCategories() async {
    BaseModel<List<BudgetCategoryModel>>? budgetCategories;

    try {
      isLoading(true);

      budgetCategories = await DataRepositoryImpl().getBudgetCategories();
      print("object ${budgetCategories.data!.length}");
    } catch (e) {} finally {
      Future.delayed(Duration(seconds: 1), () async {
        isLoading(false);
      });
    }

    return budgetCategories!.data!;
  }

  Future<List<RecurranceModel>> getRecurranceList() async {
    BaseModel<List<RecurranceModel>>? recurranceList;

    try {
      isLoading(true);

      recurranceList = await DataRepositoryImpl().getRecurranceType();
      print("object ${recurranceList.data!.length}");
    } catch (e) {} finally {
      Future.delayed(Duration(seconds: 1), () async {
        isLoading(false);
      });
    }

    return recurranceList!.data!;
  }

  Future<List<ExpenseSourceModel>> getExpenseSourceList() async {
    BaseModel<List<ExpenseSourceModel>>? expenseSourceList;

    try {
      isLoading(true);

      expenseSourceList = await DataRepositoryImpl().getExpenseSource();
      print("object ${expenseSourceList.data!.length}");
    } catch (e) {} finally {
      Future.delayed(Duration(seconds: 1), () async {
        isLoading(false);
      });
    }

    return expenseSourceList!.data!;
  }

  void modalBottomSheetMenu(
      BuildContext context,
      List<BudgetCategoryModel> imageList,
      Function(BudgetCategoryModel incomeCategoryModel) iconClicked) {
    showModalBottomSheetApp(
        dismissOnTap: true,
        context: context,
        builder: (builder) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15),
              Center(
                child: Container(
                  width: 100,
                  height: 5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(3),
                    ),
                    color: Theme.of(context).primaryColor.withOpacity(.12),
                  ),
                ),
              ),
              SizedBox(height: 25),
              Flexible(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Obx(
                    () => (isLoading())
                        ? Center(child: LoadingUI())
                        : GridView.builder(
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 30 / 27,
                            ),
                            itemCount: imageList.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Container(
                                    height: 55,
                                    width: 55,
                                    margin: EdgeInsets.only(bottom: 5),
                                    decoration: BoxDecoration(
                                      color: DataRepositoryImpl()
                                          .iconUrl(imageList[index].name!)!
                                          .colorName,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(30)),
                                    ),
                                    child: IconButton(
                                      padding: EdgeInsets.all(0),
                                      icon: Icon(
                                        DataRepositoryImpl()
                                            .iconUrl(imageList[index].name!)!
                                            .iconName,
                                        size: 35,
                                        color: whiteColor,
                                      ),
                                      onPressed: () {
                                        //Navigator.of(context).pop();
                                        setExpenseMode(imageList[index]);
                                        iconClicked(imageList[index]);
                                      },
                                    ),
                                  ),
                                  Text(
                                    imageList[index].name!,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              );
                            },
                          ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              )
            ],
          );
        },
        statusBarHeight: Get.height * .8);
  }

  void recurranceModal(BuildContext context, List<RecurranceModel> imageList,
      Function(RecurranceModel recurranceModel) iconClicked) {
    showModalBottomSheetApp(
      dismissOnTap: true,
      context: context,
      builder: (builder) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15),
            Center(
              child: Container(
                width: 100,
                height: 5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(3),
                  ),
                  color: Theme.of(context).primaryColor.withOpacity(.12),
                ),
              ),
            ),
            SizedBox(height: 25),
            Flexible(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Obx(() => (isLoading())
                    ? Center(child: LoadingUI())
                    : RecurranceList(recurranceList, iconClicked)),
              ),
            ),
            SizedBox(
              height: 5,
            )
          ],
        );
      },
      statusBarHeight: Get.height * .5,
    );
  }

  void expenseSourceModal(
      BuildContext context,
      List<ExpenseSourceModel> imageList,
      Function(ExpenseSourceModel recurranceModel) iconClicked) {
    showModalBottomSheetApp(
      dismissOnTap: true,
      context: context,
      builder: (builder) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15),
            Center(
              child: Container(
                width: 100,
                height: 5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(3),
                  ),
                  color: Theme.of(context).primaryColor.withOpacity(.12),
                ),
              ),
            ),
            SizedBox(height: 25),
            Flexible(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Obx(() => (isLoading())
                    ? Center(child: LoadingUI())
                    : ExpenseSourceList(expenseSourceList, iconClicked)),
              ),
            ),
            SizedBox(
              height: 5,
            )
          ],
        );
      },
      statusBarHeight: Get.height * .5,
    );
  }
}
