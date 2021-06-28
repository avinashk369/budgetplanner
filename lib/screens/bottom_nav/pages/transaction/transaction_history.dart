import 'package:budgetplanner/controllers/transaction_controller.dart';
import 'package:budgetplanner/screens/bottom_nav/pages/poc/grouped_list.dart';
import 'package:budgetplanner/utils/category_constants.dart';
import 'package:budgetplanner/utils/string_constants.dart';
import 'package:budgetplanner/widgets/loading_ui.dart';
import 'package:budgetplanner/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class TransactionHistory extends GetView {
  @override
  Widget build(BuildContext context) {
    final controller = TransactionEntryController.to;

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Container(
        child: Obx(() {
          if (controller.transactionList.isEmpty) {
            return Center(child: LoadingUI());
          } else {
            return controller.isLoading()
                ? Center(child: LoadingUI())
                : GroupedList(
                    transactionModelList: controller.transactionList,
                  );
          }
        }),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_list),
        onPressed: () {
          () {
            controller.transactionModel
                .bindStream(controller.getTransactionList(income)!);
            print("Avinash ${controller.transactionModel.value!.length}");
          }();
        },
      ),
    );
  }
}
