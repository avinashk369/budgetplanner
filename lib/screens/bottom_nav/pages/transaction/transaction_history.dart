import 'package:budgetplanner/controllers/ad_controller.dart';
import 'package:budgetplanner/controllers/expense_controller.dart';
import 'package:budgetplanner/controllers/income_controller.dart';
import 'package:budgetplanner/controllers/transaction_controller.dart';
import 'package:budgetplanner/screens/bottom_nav/pages/poc/grouped_list.dart';
import 'package:budgetplanner/utils/PreferenceUtils.dart';
import 'package:budgetplanner/utils/app_constants.dart';
import 'package:budgetplanner/utils/category_constants.dart';
import 'package:budgetplanner/utils/controller_constants.dart';
import 'package:budgetplanner/utils/route_constants.dart';
import 'package:budgetplanner/utils/string_constants.dart';
import 'package:budgetplanner/utils/styles.dart';
import 'package:budgetplanner/widgets/draggable_bottom_sheet.dart';
import 'package:budgetplanner/widgets/filter_modal_layout.dart';
import 'package:budgetplanner/widgets/no_data.dart';
import 'package:budgetplanner/widgets/trx_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';

class TransactionHistory extends GetView {
  void showInterstitialAd(AdController adCont) {
    print("  reward earned");
    //to display intertitial ad
    if (adCont.isInterstitialAdReady.value) {
      adCont.interstitialAd?.show();
    }
  }

  @override
  Widget build(BuildContext context) {
    var date = DateTime.now();

    // print("month name ${date.month}");
    // print(
    //     "print no of days of the month ${DateTime(date.year, date.month - 4, 0).day}");
    // DateFormat format = DateFormat.yMMMMd();
    // print("month name ${DateTime(date.year, date.month - 6, 0).toString()}");
    final adCont = AdController.tagged(adController);
    final controller = TransactionEntryController.to;
    //used for transaction filter option
    final expController = ExpenseController.tagged(expenseController);
    final incController = IncomeController.tagged(incomeController);
    final String userId = PreferenceUtils.getString(user_id);

    controller.bindTransaction(DateTime.now());

    showInterstitialAd(adCont);
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(top: 6.0),
                child: Text(
                  lbl_history.tr,
                  style: kLabelStyle.copyWith(
                    color: Theme.of(context).hintColor,
                    fontSize: 18,
                  ),
                )),
          ],
        ),
        actions: <Widget>[
          Row(
            children: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 20,
                  ),
                  color: Theme.of(context).hintColor,
                  onPressed: () {
                    controller.setNextMonth(controller.nextMonth.value - 1);
                    controller.setPrevMonth(controller.nextMonth.value + 1 - 1);
                    print("prev month ${controller.prevMonth.value}");
                    controller.transactionModel.bindStream(
                        controller.getTransactionList(
                            userId,
                            income,
                            DateTime(date.year,
                                date.month + controller.prevMonth.value, 0),
                            controller.filterCats.value)!);
                  }),
              Obx(
                () => InkWell(
                  onTap: () {
                    controller.setPrevMonth(1);
                    controller.setNextMonth(1);
                    controller.transactionModel.bindStream(
                        controller.getTransactionList(userId, income,
                            DateTime.now(), controller.filterCats.value)!);
                  },
                  child: Text(
                    DateFormat('LLL').format(
                          DateTime(date.year,
                              date.month + controller.nextMonth.value, 0),
                        ) +
                        " " +
                        DateFormat('y').format(
                          DateTime(date.year,
                              date.month + controller.nextMonth.value, 0),
                        ),
                    style: kLabelStyle.copyWith(
                      color: Theme.of(context).hintColor,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                  ),
                  color: Theme.of(context).hintColor,
                  onPressed: () {
                    controller.setNextMonth(controller.nextMonth.value + 1);
                    print("next month ${controller.nextMonth.value}");
                    controller.transactionModel.bindStream(
                        controller.getTransactionList(
                            userId,
                            income,
                            DateTime(date.year,
                                date.month + controller.nextMonth.value, 0),
                            controller.filterCats.value)!);
                  }),
            ],
          ),
        ],
      ),
      body: Container(
        child: Obx(() {
          if (controller.transactionList.isEmpty) {
            return NoData(
              title: lbl_no_transaction.tr,
              message: desc_no_transaction.tr,
              imageUrl: 'assets/grp.png',
              index: 2,
              goTo: () {
                Navigator.of(context).pushNamed(addTransactionRoute);
              },
            );
          } else {
            return controller.isLoading()
                ? TrxShimmer()
                : GroupedList(
                    transactionModelList: controller.transactionList,
                  );
          }
        }),
      ),
      floatingActionButton: Stack(
        children: [
          Visibility(
            visible: true,
            child: Obx(() {
              return Positioned(
                left: controller.position.value.dx,
                top: controller.position.value.dy,
                child: Draggable(
                  feedback: FloatingActionButton(
                    child: Icon(
                      Icons.filter_list,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: () {
                      () {
                        // controller.transactionModel.bindStream(
                        //     controller.getTransactionList(
                        //         userId, income, DateTime.now())!);
                        // print(
                        //     "Avinash ${controller.transactionModel.value.length}");
                      }();
                    },
                  ),
                  child: FloatingActionButton(
                    child: Icon(
                      Icons.filter_list,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: () {
                      () {
                        // controller.transactionModel.bindStream(
                        //     controller.getTransactionList(
                        //         userId, income, DateTime.now())!);
                        showModalBottomSheet(
                          context: context,
                          enableDrag: true,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) => DraggableBottomSheet(context)
                              .buildSheet(FilterLayout(
                            removeFilter: (val) {
                              controller.transactionModel.bindStream(
                                  controller.getTransactionList(
                                      userId,
                                      income,
                                      DateTime(
                                          date.year,
                                          date.month +
                                              controller.nextMonth.value,
                                          0),
                                      val)!);
                              Navigator.of(context).pop();
                            },
                            applyFilter: (values) {
                              controller.setFiterCat(values);

                              controller.transactionModel.bindStream(
                                  controller.getTransactionList(
                                      userId,
                                      income,
                                      DateTime(
                                          date.year,
                                          date.month +
                                              controller.nextMonth.value,
                                          0),
                                      controller.filterCats.value)!);
                              Navigator.of(context).pop();
                            },
                          )),
                        );
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
