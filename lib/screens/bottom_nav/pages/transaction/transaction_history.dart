import 'package:budgetplanner/controllers/ad_controller.dart';
import 'package:budgetplanner/controllers/expense_controller.dart';
import 'package:budgetplanner/controllers/income_controller.dart';
import 'package:budgetplanner/controllers/transaction_controller.dart';
import 'package:budgetplanner/models/expense_source_model.dart';
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
import 'package:budgetplanner/widgets/loading_ui.dart';
import 'package:budgetplanner/widgets/no_data.dart';
import 'package:budgetplanner/widgets/theme_constants.dart';
import 'package:budgetplanner/widgets/trx_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';

class TransactionHistory extends StatefulWidget {
  const TransactionHistory({Key? key}) : super(key: key);

  @override
  _TransactionHistoryState createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  final adCont = AdController.tagged(adController);
  final controller = TransactionEntryController.to;
  //used for transaction filter option
  final expController = ExpenseController.tagged(expenseController);
  final incController = IncomeController.tagged(incomeController);
  var date = DateTime.now();
  late String userId;
  @override
  void initState() {
    // print("month name ${date.month}");
    // print(
    //     "print no of days of the month ${DateTime(date.year, date.month - 4, 0).day}");
    // DateFormat format = DateFormat.yMMMMd();
    // print("month name ${DateTime(date.year, date.month - 6, 0).toString()}");

    userId = PreferenceUtils.getString(user_id);

    controller.bindTransaction(DateTime.now(), controller.expenseSource.value);

    // TODO: implement initState
    super.initState();
  }

  void showInterstitialAd(AdController adCont) {
    print("Avinash  reward earned");
    //to display intertitial ad
    if (adCont.isInterstitialAdReady.value) {
      adCont.interstitialAd?.show();
    }
  }

  @override
  Widget build(BuildContext context) {
    showInterstitialAd(adCont);
    return // TODO: implement build
        Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(top: 6.0),
                child: Text(
                  lbl_history.tr,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Theme.of(context).hintColor.withOpacity(.8),
                        fontWeight: FontWeight.bold,
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
                  color: Theme.of(context).hintColor.withOpacity(.8),
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
                            controller.filterCats.value,
                            controller.expenseSource.value)!);
                  }),
              Obx(
                () => InkWell(
                  onTap: () {
                    controller.setPrevMonth(1);
                    controller.setNextMonth(1);
                    controller.transactionModel.bindStream(
                        controller.getTransactionList(
                            userId,
                            income,
                            DateTime.now(),
                            controller.filterCats.value,
                            controller.expenseSource.value)!);
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
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: Theme.of(context).hintColor.withOpacity(.8),
                        ),
                  ),
                ),
              ),
              IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                  ),
                  color: Theme.of(context).hintColor.withOpacity(.8),
                  onPressed: () {
                    controller.setNextMonth(controller.nextMonth.value + 1);
                    print("next month ${controller.nextMonth.value}");
                    controller.transactionModel.bindStream(
                        controller.getTransactionList(
                            userId,
                            income,
                            DateTime(date.year,
                                date.month + controller.nextMonth.value, 0),
                            controller.filterCats.value,
                            controller.expenseSource.value)!);
                  }),
            ],
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Obx(
                      () => (!expController.isExpLoading())
                          ? Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.transparent,
                                            width: 1)),
                                    height: 35,
                                    child: renderExpenseFilter(
                                        controller,
                                        expController.expenseSourceList,
                                        userId),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: FilterChip(
                                    onSelected: (b) {
                                      //print(expenseSourceList[index].name!);
                                      controller.expenseSource.value = "";

                                      controller.transactionModel.bindStream(
                                          controller.getTransactionList(
                                              userId,
                                              income,
                                              DateTime(
                                                  date.year,
                                                  date.month +
                                                      controller
                                                          .nextMonth.value,
                                                  0),
                                              controller.filterCats.value,
                                              controller.expenseSource.value)!);
                                    },
                                    showCheckmark: false,
                                    backgroundColor:
                                        Theme.of(context).colorScheme.secondary,
                                    selectedColor:
                                        Theme.of(context).colorScheme.secondary,
                                    label: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 0, 8, 3),
                                      child: Text(
                                        "Clear",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                                fontWeight: FontWeight.w700,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                      ),
                                    ),
                                    selected: true,
                                  ),
                                ),
                              ],
                            )
                          : LoadingUI(),
                    ),
                    Obx(() {
                      if (controller.transactionList.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: NoData(
                            title: lbl_no_transaction.tr,
                            message: desc_no_transaction.tr,
                            imageUrl: 'assets/grp.png',
                            index: 2,
                            goTo: () {
                              Navigator.of(context)
                                  .pushNamed(addTransactionRoute);
                            },
                          ),
                        );
                      } else {
                        return controller.isLoading()
                            ? TrxShimmer()
                            : GroupedList(
                                transactionModelList:
                                    controller.transactionList,
                              );
                      }
                    }),
                  ],
                ),
              ],
            ),
          ),
        ],
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
                    heroTag: "filter",
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
                                      val,
                                      controller.expenseSource.value)!);
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
                                      controller.filterCats.value,
                                      controller.expenseSource.value)!);
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

  /// The material design primary color swatches, excluding grey.
  static List<Color> primaries = <Color>[
    Colors.greenAccent,
    Colors.indigo[100]!,
    Colors.orange[100]!,
  ];

  Widget renderExpenseFilter(
      TransactionEntryController transactionEntryController,
      List<ExpenseSourceModel> expenseSourceList,
      String userId) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: expenseSourceList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3),
          child: FilterChip(
            onSelected: (b) {
              var date = DateTime.now();
              //print(expenseSourceList[index].name!);
              transactionEntryController.expenseSource.value =
                  expenseSourceList[index].name!;
              // transactionEntryController.bindTransaction(DateTime.now(),
              //     transactionEntryController.expenseSource.value);

              transactionEntryController.transactionModel.bindStream(
                  transactionEntryController.getTransactionList(
                      userId,
                      income,
                      DateTime(
                          date.year,
                          date.month +
                              transactionEntryController.nextMonth.value,
                          0),
                      transactionEntryController.filterCats.value,
                      transactionEntryController.expenseSource.value)!);
              // transactionEntryController.transactionModel1.bindStream(
              //     transactionEntryController.filterTransactionList(
              //         transactionEntryController.transactionList,
              //         expenseSourceList[index].name!)!);
            },
            showCheckmark: false,
            backgroundColor: Colors.grey.shade200,
            selectedColor: Colors.grey.shade200,
            label: Padding(
              padding: const EdgeInsets.only(bottom: 3),
              child: Text(
                expenseSourceList[index].name!,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w700,
                    color: darkColor.withOpacity(.8)),
              ),
            ),
            selected: true,
          ),
        );
      },
    );
  }
}
