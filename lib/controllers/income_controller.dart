import 'package:budgetplanner/controllers/base_controller.dart';
import 'package:budgetplanner/controllers/transaction_controller.dart';
import 'package:budgetplanner/models/BaseModel.dart';
import 'package:budgetplanner/models/income_model.dart';
import 'package:budgetplanner/models/recurrance_model.dart';
import 'package:budgetplanner/models/transaction_model.dart';
import 'package:budgetplanner/resources/firestore/dataRepositoryImpl.dart';
import 'package:budgetplanner/utils/PreferenceUtils.dart';
import 'package:budgetplanner/utils/app_constants.dart';
import 'package:budgetplanner/utils/category_constants.dart';
import 'package:budgetplanner/utils/string_constants.dart';
import 'package:budgetplanner/widgets/_ModalBottomSheetLayout.dart';
import 'package:budgetplanner/widgets/loading_dialog.dart';
import 'package:budgetplanner/widgets/loading_ui.dart';
import 'package:budgetplanner/widgets/recurrance_list.dart';
import 'package:budgetplanner/widgets/snack_bar.dart';
import 'package:budgetplanner/widgets/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IncomeController extends BaseController {
  var isLoading = true.obs;
  var isRecurring = false.obs;
  final GlobalKey<FormState> incomeKey = GlobalKey<FormState>();
  final GlobalKey<State> keyLoader = new GlobalKey<State>();
  late TextEditingController amountController, notesController;
  late List<IncomeModel> catList;
  late List<RecurranceModel> recurranceList;
  static IncomeController get to => Get.find<IncomeController>();
  static IncomeController tagged(String name) =>
      Get.find<IncomeController>(tag: name);
  var incomeModel = IncomeModel().obs;
  var recurranceModel = RecurranceModel().obs;
  final controller = TransactionEntryController.to;
  setIncomeMode(IncomeModel income) => incomeModel(income);
  setRecurranceModeel(RecurranceModel recurrance) =>
      recurranceModel(recurrance);

  @override
  void onInit() {
    // TODO: implement onInit

    amountController = TextEditingController(text: "100");
    notesController = TextEditingController(text: "test transaction");
    () async {
      catList = await getIncomeCategories();
      recurranceList = await getRecurranceList();
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
    final isValid = incomeKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    if (GetUtils.isNull(incomeModel.value.name)) {
      print("Please select income");
      SnackBarDialog.displaySnackbar(
        "Income",
        "Please select income source",
      );

      return;
    }
    if (recurranceModel.value.name == null) print("Please select recurrance");
    if (incomeKey.currentState!.validate()) {
      print(amountController.text);
      print(notesController.text);
      print(recurranceModel.value.name ?? recurrance);
      print(incomeModel.value.name);
      try {
        isLoading(true);
        LoadingDialog.showLoadingDialog(context, keyLoader);
        TransactionModel transactionModel = TransactionModel();
        transactionModel.amount = double.parse(amountController.text);
        transactionModel.notes = notesController.text;
        transactionModel.catName = incomeModel.value.name;
        transactionModel.isRecurring = isRecurring();
        transactionModel.transactionType = income;
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
  }

/**
 * update income transaction
 */
  void updatetransaction(
      BuildContext context, TransactionModel transactionModel) async {
    try {
      isLoading(true);
      LoadingDialog.showLoadingDialog(context, keyLoader);

      transactionModel.amount = double.parse(amountController.text);
      transactionModel.notes = notesController.text;
      transactionModel.catName = incomeModel.value.name;
      transactionModel.transactionType = income;

      transactionModel.isRecurring = isRecurring();

      transactionModel.updatedOn = DateTime.now();
      transactionModel.recurrance =
          recurranceModel.value.name ?? def_recurrance;
      await DataRepositoryImpl().updateTransaction(transactionModel);
    } catch (e) {
      Navigator.of(keyLoader.currentContext!, rootNavigator: true).pop();
      SnackBarDialog.displaySnackbar(
        "Transaction",
        "Ooops!!!...transaction not updated!",
      );
    } finally {
      isLoading(false);
      Navigator.of(keyLoader.currentContext!, rootNavigator: true).pop();
      Get.showSnackbar(SnackBarDialog.getSnanck(
              "Transaction updated successfully!", "Transaction"))!
          .whenComplete(() => Get.back(
                canPop: true,
              ));
    }
  }

  Future<List<IncomeModel>> getIncomeCategories() async {
    BaseModel<List<IncomeModel>>? incomeCategories;

    try {
      isLoading(true);

      incomeCategories = await DataRepositoryImpl().getIncomeCategories();
      print("object ${incomeCategories.data!.length}");
    } catch (e) {} finally {
      Future.delayed(Duration(seconds: 1), () async {
        isLoading(false);
      });
    }

    return incomeCategories!.data!;
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

  void modalBottomSheetMenu(BuildContext context, List<IncomeModel> imageList,
      Function(IncomeModel incomeCategoryModel) iconClicked) {
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
                                      setIncomeMode(imageList[index]);
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
      statusBarHeight: Get.height * .5,
    );
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
}
