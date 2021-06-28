import 'package:budgetplanner/controllers/transaction_controller.dart';
import 'package:budgetplanner/screens/bottom_nav/pages/poc/grouped_list.d.dart';
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
        child: Obx(
          () => controller.isLoading()
              ? Center(child: LoadingUI())
              : GroupedList(
                  transactionModelList: controller.transactionModel,
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_list),
        onPressed: () {
          () async {
            controller.transactionModel =
                await controller.getTransactionList(income);
            print("Avinash ${controller.transactionModel.length}");
          }();
        },
      ),
    );
  }
}
