import 'package:budgetplanner/controllers/transaction_controller.dart';
import 'package:budgetplanner/screens/bottom_nav/pages/poc/grouped_list.dart';
import 'package:budgetplanner/utils/PreferenceUtils.dart';
import 'package:budgetplanner/utils/app_constants.dart';
import 'package:budgetplanner/utils/category_constants.dart';
import 'package:budgetplanner/utils/string_constants.dart';
import 'package:budgetplanner/widgets/loading_ui.dart';
import 'package:budgetplanner/widgets/no_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class TransactionHistory extends GetView {
  @override
  Widget build(BuildContext context) {
    final controller = TransactionEntryController.to;
    final String userId = PreferenceUtils.getString(user_id);
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Container(
        child: Obx(() {
          if (controller.transactionList.isEmpty) {
            return NoData(
              message: lbl_no_transaction.tr,
              imageUrl:
                  "https://image.freepik.com/free-vector/estate-tax-composition_98292-7428.jpg",
              index: 2,
            );
          } else {
            return controller.isLoading()
                ? Center(child: LoadingUI())
                : GroupedList(
                    transactionModelList: controller.transactionList,
                  );
          }
        }),
      ),
      floatingActionButton: Stack(
        children: [
          Visibility(
            visible: false,
            child: Obx(() {
              return Positioned(
                left: controller.position.value.dx,
                top: controller.position.value.dy,
                child: Draggable(
                  feedback: FloatingActionButton(
                    child: Icon(Icons.filter_list),
                    onPressed: () {
                      () {
                        controller.transactionModel.bindStream(
                            controller.getTransactionList(userId, income)!);
                        print(
                            "Avinash ${controller.transactionModel.value.length}");
                      }();
                    },
                  ),
                  child: FloatingActionButton(
                    child: Icon(Icons.filter_list),
                    onPressed: () {
                      () {
                        controller.transactionModel.bindStream(
                            controller.getTransactionList(userId, income)!);
                        print(
                            "Avinash ${controller.transactionModel.value.length}");
                      }();
                    },
                  ),
                  childWhenDragging: Container(),
                  onDragEnd: (details) {
                    if (details.offset.dx <= Get.width * .82 &&
                        details.offset.dy <= Get.height * .82 &&
                        details.offset.dx >= 10 &&
                        details.offset.dy >= 10)
                      controller.setposition(details.offset);
                    print(details.offset);
                    print(details.offset.dx);
                    print(details.offset.dy);
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
