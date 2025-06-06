import 'package:budgetplanner/models/BaseModel.dart';
import 'package:budgetplanner/models/budget_category_model.dart';
import 'package:budgetplanner/models/budget_model.dart';
import 'package:budgetplanner/resources/firestore/dataRepositoryImpl.dart';
import 'package:budgetplanner/screens/bottom_nav/pages/budget/update_budget.dart';
import 'package:budgetplanner/utils/PreferenceUtils.dart';
import 'package:budgetplanner/utils/app_constants.dart';
import 'package:budgetplanner/utils/string_constants.dart';
import 'package:budgetplanner/widgets/_ModalBottomSheetLayout.dart';
import 'package:budgetplanner/widgets/custom_theme.dart';
import 'package:budgetplanner/widgets/loading_dialog.dart';
import 'package:budgetplanner/widgets/loading_ui.dart';
import 'package:budgetplanner/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';

class BudgetController extends GetxController {
  var isLoading = true.obs;

  final GlobalKey<FormState> budgetKey = GlobalKey<FormState>();
  final GlobalKey<FormState> updateBudgetKey = GlobalKey<FormState>();
  final GlobalKey<State> keyLoader = new GlobalKey<State>();
  late TextEditingController amountController, notesController;
  late List<BudgetCategoryModel> catList;
  var budgetCatModel = BudgetCategoryModel().obs;
  setBudgetModel(BudgetCategoryModel income) => budgetCatModel(income);
  var budgetDetail = BudgetModel().obs;
  setBudget(BudgetModel budget) => budgetDetail(budget);
  static BudgetController get to => Get.find<BudgetController>();
  static BudgetController tagged(String name) =>
      Get.find<BudgetController>(tag: name);

  var currentIndex = 0.obs;
  var slidervalue = 0.0.obs;
  var isSliding = false.obs;
  RxMap message = {}.obs;

  PageController pageController =
      PageController(viewportFraction: 0.5, initialPage: 0);
  var currencySymbol =
      PreferenceUtils.getString(currancy_symbol, defValue: '\u20B9').obs;

  late String userId;
  @override
  void onInit() {
    catList = [];
    userId = PreferenceUtils.getString(user_id);
    amountController = TextEditingController();
    notesController = TextEditingController();

    () async {
      catList = await getBudgetCategories();
    }();
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose

    amountController.dispose();
    notesController.dispose();
    // budgetCatModel = Rx<BudgetCategoryModel>(BudgetCategoryModel());
    // setBudgetModel(BudgetCategoryModel());
    // print("disposing");
    super.onClose();
  }

  Future<List<BudgetCategoryModel>> getBudgetCategories() async {
    BaseModel<List<BudgetCategoryModel>>? budgetCategories;

    try {
      isLoading(true);

      budgetCategories = await DataRepositoryImpl().getBudgetCategories();
      print("object ${budgetCategories.data!.length}");
    } catch (e) {
    } finally {
      Future.delayed(Duration(seconds: 1), () async {
        isLoading(false);
      });
    }

    return budgetCategories!.data!;
  }

  String? validateAmount(String amount) {
    if (amount.length < 1) {
      return lbl_amount_error.tr;
    }
    return null;
  }

  String? validatePassword(String password) {
    if (password.length <= 6) {
      return lbl_notes_error.tr;
    }
    return null;
  }

  void submitIncomeRecord(BuildContext context) async {
    final isValid = budgetKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    if (GetUtils.isNull(budgetCatModel.value.name)) {
      SnackBarDialog.displaySnackbar(budgetTab.tr, lbl_select_budget_cat.tr);

      return;
    }

    if (budgetKey.currentState!.validate()) {
      //check if budget eist with the same name if yes then open update screen else let it save
      BudgetModel? bm = await DataRepositoryImpl()
          .getBudgetModel(budgetCatModel.value.name!, userId);
      if (bm != null) {
        print(bm.amount);
        Get.to(UpdateBudget(budgetModel: bm));
      } else {
        print(amountController.text);
        print(notesController.text);

        print(budgetCatModel.value.name);
        try {
          isLoading(true);
          LoadingDialog.showLoadingDialog(context, keyLoader);
          BudgetModel budgetModel = BudgetModel();
          budgetModel.amount = double.parse(amountController.text);
          budgetModel.notes = notesController.text;
          budgetModel.catName = budgetCatModel.value.name;
          budgetModel.monthName = DateFormat('LLLL').format(DateTime.now());
          budgetModel.createdOn = DateTime.now();
          budgetModel.userId = PreferenceUtils.getString(user_id);
          await DataRepositoryImpl().saveBudget(budgetModel);
          setBudgetModel(BudgetCategoryModel());
        } catch (e) {
          Navigator.of(keyLoader.currentContext!, rootNavigator: true).pop();
          SnackBarDialog.displaySnackbar(
            budgetTab.tr,
            lbl_budget_not_saved.tr,
          );
        } finally {
          isLoading(false);
          Navigator.of(keyLoader.currentContext!, rootNavigator: true).pop();
          SnackBarDialog.displaySuccessSnackbar(
            budgetTab.tr,
            lbl_budget_save_success.tr,
          );
        }
      }
    }
  }

  ///save or update budget
  void saveOrUpdateBudget(BudgetModel budgetModel, BuildContext context) async {
    try {
      isLoading(true);
      LoadingDialog.showLoadingDialog(context, keyLoader);

      BudgetModel? bm = await DataRepositoryImpl()
          .getBudgetModel(budgetCatModel.value.name!, userId);
      if (bm != null) {
        budgetModel.notes = budgetCatModel.value.name!;
        bm.amount = slidervalue.value.roundToDouble();
        bm.updatedOn = DateTime.now();

        await DataRepositoryImpl().updateBudget(bm);
      } else {
        budgetModel.catName = budgetCatModel.value.name!;
        budgetModel.amount = slidervalue.value.roundToDouble();
        budgetModel.notes = budgetCatModel.value.name!;
        budgetModel.monthName = DateFormat('LLLL').format(DateTime.now());
        budgetModel.createdOn = DateTime.now();
        budgetModel.userId = PreferenceUtils.getString(user_id);
        await DataRepositoryImpl().saveBudget(budgetModel);
      }
    } catch (e) {
      Navigator.of(keyLoader.currentContext!, rootNavigator: true).pop();
      SnackBarDialog.displaySnackbar(
        budgetTab.tr,
        lbl_budget_not_saved.tr,
      );
    } finally {
      Navigator.of(keyLoader.currentContext!, rootNavigator: true).pop();
      SnackBarDialog.displaySuccessSnackbar(
        budgetTab.tr,
        lbl_budget_save_success.tr,
      );
    }
  }

/**
 * update budget
 */
  void updateBudget(BuildContext context, BudgetModel budgetModel) async {
    try {
      isLoading(true);
      LoadingDialog.showLoadingDialog(context, keyLoader);

      budgetModel.amount = double.parse(amountController.text);
      budgetModel.notes = notesController.text;
      budgetModel.catName = budgetCatModel.value.name;

      await DataRepositoryImpl().updateBudget(budgetModel);
    } catch (e) {
      Navigator.of(keyLoader.currentContext!, rootNavigator: true).pop();
      SnackBarDialog.displaySnackbar(
        transactionTab.tr,
        lbl_budget_not_update.tr,
      );
    } finally {
      isLoading(false);

      Get.showSnackbar(
              SnackBarDialog.getSnanck(lbl_budget_update.tr, budgetTab.tr))
          .future;
      Navigator.of(keyLoader.currentContext!, rootNavigator: true).pop();
    }
  }

  Future deleteBudget(BuildContext context, String id) async {
    try {
      isLoading(true);
      LoadingDialog.showLoadingDialog(context, keyLoader);
      await DataRepositoryImpl().deleteBudget(id);
    } catch (e) {
      Navigator.of(keyLoader.currentContext!, rootNavigator: true).pop();
      SnackBarDialog.displaySnackbar(
        budgetTab.tr,
        lbl_budget_not_delete.tr,
      );
    } finally {
      isLoading(false);

      Get.showSnackbar(SnackBarDialog.getSnanck(
              lbl_budget_delete_success.tr, budgetTab.tr))
          .future;
      Navigator.of(keyLoader.currentContext!, rootNavigator: true).pop();
    }
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
                  width: 70,
                  height: 5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(3),
                    ),
                    color: Theme.of(context).hintColor.withOpacity(.12),
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
                                      color: (CustomTheme().currentTheme ==
                                              ThemeMode.dark)
                                          ? Colors.black12
                                          : Colors.grey[100],
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
                                        color: DataRepositoryImpl()
                                            .iconUrl(imageList[index].name!)!
                                            .colorName,
                                      ),
                                      onPressed: () {
                                        //Navigator.of(context).pop();
                                        setBudgetModel(imageList[index]);
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
}
