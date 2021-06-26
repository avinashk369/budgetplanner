import 'package:budgetplanner/models/BaseModel.dart';
import 'package:budgetplanner/models/transaction_model.dart';
import 'package:budgetplanner/models/transaction_type_model.dart';
import 'package:budgetplanner/resources/firestore/dataRepositoryImpl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionEntryController extends GetxController {
  late List<TransactionType> transactionTypeList;
  var isLoading = true.obs;
  late List<TransactionModel> transactionModel;
  static TransactionEntryController get to =>
      Get.find<TransactionEntryController>();
  @override
  void onInit() {
    // TODO: implement onInit
    () async {
      transactionTypeList = await getTransactionTypeList();
      transactionModel = await getTransactionList();
      //if (!isLoading())
      print("transaction list lengh ${transactionModel.length}");
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

  Future<List<TransactionModel>> getTransactionList() async {
    BaseModel<List<TransactionModel>>? transactionList;
    try {
      isLoading(true);
      transactionList = await DataRepositoryImpl().getTransactions();
    } catch (e) {} finally {
      isLoading(false);
    }

    return transactionList!.data!;
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
