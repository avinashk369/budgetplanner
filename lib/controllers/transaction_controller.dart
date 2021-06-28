import 'package:budgetplanner/models/BaseModel.dart';
import 'package:budgetplanner/models/transaction_model.dart';
import 'package:budgetplanner/models/transaction_type_model.dart';
import 'package:budgetplanner/resources/firestore/dataRepositoryImpl.dart';
import 'package:budgetplanner/widgets/snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionEntryController extends GetxController {
  late List<TransactionType> transactionTypeList;
  var isLoading = true.obs;
  static TransactionEntryController get to =>
      Get.find<TransactionEntryController>();

  List<TransactionModel> get transactionList => transactionModel.value;

  Rx<List<TransactionModel>> transactionModel = Rx<List<TransactionModel>>([]);
  var position = Offset(Get.width * .83, Get.height * .83).obs;
  setposition(Offset offset) => position(offset);
  @override
  void onInit() {
    // TODO: implement onInit
    () async {
      transactionTypeList = await getTransactionTypeList();
      transactionModel.bindStream(getTransactionList("")!);
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

  Future deletetransaction(String id) async {
    try {
      isLoading(true);
      await DataRepositoryImpl().deleteTransaction(id);
    } catch (e) {
      SnackBarDialog.displaySnackbar(
        "Transaction",
        "Ooops!!!...transaction not deleted!",
      );
    } finally {
      isLoading(false);
      SnackBarDialog.displaySuccessSnackbar(
        "Transaction",
        "Deleted Successfully!",
      );
    }
  }

  void updatetransaction(TransactionModel transactionModel) async {
    try {
      isLoading(true);
      await DataRepositoryImpl().updateTransaction(transactionModel);
    } catch (e) {
      SnackBarDialog.displaySnackbar(
        "Transaction",
        "Ooops!!!...transaction not updated!",
      );
    } finally {
      isLoading(false);
      SnackBarDialog.displaySuccessSnackbar(
        "Transaction",
        "Updated Successfully!",
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

  Stream<List<TransactionModel>>? getTransactionList(String transactionType) {
    BaseModel<List<TransactionModel>>? transactionList;
    try {
      isLoading(true);
      return DataRepositoryImpl().getTransactions(transactionType);
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
