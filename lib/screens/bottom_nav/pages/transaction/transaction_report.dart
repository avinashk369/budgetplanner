import 'package:budgetplanner/ad/native_ad.dart';
import 'package:budgetplanner/controllers/ad_controller.dart';
import 'package:budgetplanner/controllers/transaction_controller.dart';
import 'package:budgetplanner/models/transaction_model.dart';
import 'package:budgetplanner/resources/firestore/dataRepositoryImpl.dart';
import 'package:budgetplanner/screens/bottom_nav/pages/transaction/BarChartSample5.dart';
import 'package:budgetplanner/screens/bottom_nav/pages/transaction/category_report.dart';
import 'package:budgetplanner/utils/PreferenceUtils.dart';
import 'package:budgetplanner/utils/app_constants.dart';
import 'package:budgetplanner/utils/category_constants.dart';
import 'package:budgetplanner/utils/controller_constants.dart';
import 'package:budgetplanner/utils/string_constants.dart';
import 'package:budgetplanner/utils/styles.dart';
import 'package:budgetplanner/widgets/config.dart';
import 'package:budgetplanner/widgets/theme_constants.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'PieChartSample2.dart';

class TransactionReport extends StatefulWidget {
  @override
  _TransactionReportState createState() => _TransactionReportState();
}

class _TransactionReportState extends State<TransactionReport> {
  final controller = TransactionEntryController.to;
  final adCont = AdController.tagged(adController);

  static final _kAdIndex = 2;
  List<TransactionModel>? trxList = [];

  int tappedIndex = 0;
  bool isSelected = false;
  bool isESelected = false;
  bool isExpense = true;
  List<String> filterTabs = [
    "Expense",
    "Income",
  ];
  String? currencySymbol;

  int _getDestinationItemIndex(int rawIndex) {
    if (rawIndex >= _kAdIndex && adCont.isNativeAdReady.value) {
      return rawIndex - 1;
    }
    return rawIndex;
  }

  int gv = 0;

  double totalIncome = 0;
  double totalExpense = 0;
  bool isLoaded = false;
  var date = DateTime.now();
  @override
  void initState() {
    currencySymbol =
        PreferenceUtils.getString(currancy_symbol, defValue: '\u20B9');
    isLoaded = false;
    () async {
      trxList = await controller.getAllTransactionOfYear(date.year);
      //for pie hart and list view
      controller
          .setPieChartData(controller.generateCategoryMap(trxList!, expense));
      //set total income and total expense value
      controller.generateCategoryMap(trxList!, expense).forEach((element) {
        setState(() {
          totalExpense += double.parse(element[1]);
        });
      });
      controller.generateCategoryMap(trxList!, income).forEach((element) {
        setState(() {
          isLoaded = true;
          totalIncome += double.parse(element[1]);
        });
      });
      //generateCategoryMap(expense);
    }();

    super.initState();
  }

  void generateMap() {
    var newMap = groupBy(trxList!,
        (TransactionModel model) => model.createdOn.toString().substring(0, 8));
    //validate new map
    List<List<double>> dataList = [];

    newMap.forEach((key, value) {
      //print(key);
      double incomeAmount = 0;
      double expenseAmount = 0;
      int incomeCount = 0;
      int expenseCount = 0;
      value.forEach((element) {
        switch (element.transactionType) {
          case income:
            incomeAmount += element.amount!;
            incomeCount++;
            break;
          case expense:
            expenseAmount += element.amount!;
            expenseCount++;
            break;
        }
        //print("${element.catName} ${element.transactionType}");
      });
      dataList.add([incomeAmount, expenseAmount, incomeAmount - expenseAmount]);
      print("$expenseCount $incomeCount");
    });
  }

  void showInterstitialAd(AdController adCont) {
    print("  reward earned");
    //to display intertitial ad
    if (adCont.isInterstitialAdReady.value) {
      adCont.interstitialAd?.show();
    }
  }

  @override
  Widget build(BuildContext context) {
    showInterstitialAd(adCont);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          DateFormat('y').format(DateTime.now()),
          style: kLabelStyle.copyWith(
            color: Theme.of(context).hintColor,
            fontSize: 18,
          ),
        ),
        actions: [
          Obx(
            () => (controller.piechartDataList.isNotEmpty)
                ? IconButton(
                    onPressed: () {
                      controller.getTransactions(context, trxList!);
                    },
                    icon: Icon(Icons.download,
                        color: Theme.of(context).hintColor),
                  )
                : Container(),
          )
        ],
      ),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Obx(
                  () => (controller.piechartDataList.isNotEmpty && isLoaded)
                      ? BarChartSample5(
                          dataList: trxList!,
                          totalAmount: totalIncome,
                        )
                      : Container(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.transparent, width: 1),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            color: Color(0xff64caad), //grey[100]
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(income),
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.transparent, width: 1),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            color: Color(0xff3b8c75), //grey[100]
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(expense),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                // Center(
                //   child: CupertinoSegmentedControl(
                //     children: const {
                //       0: Padding(
                //         padding:
                //             EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                //         child: Text(
                //           "Income",
                //           style: TextStyle(
                //               fontWeight: FontWeight.bold, fontSize: 16),
                //         ),
                //       ),
                //       1: Text(
                //         "Expense",
                //         style: TextStyle(
                //             fontWeight: FontWeight.bold, fontSize: 16),
                //       ),
                //     },
                //     onValueChanged: (int value) {
                //       setState(() {
                //         gv = value;
                //       });
                //     },
                //     groupValue: gv,
                //     borderColor: heenColor,
                //     // selectedColor: Colors.black,
                //     // unselectedColor: kLightPink.withOpacity(0.5),
                //     pressedColor: Colors.blueGrey[50],
                //   ),
                // ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 2),
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.transparent, width: 1),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                        color: Colors.grey[100], //grey[100]
                      ),
                      child: ListView.builder(
                        itemCount: filterTabs.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: filterTab(filterTabs[index], index),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  color: currentTheme.currentTheme == ThemeMode.dark
                      ? Colors.black12
                      : Colors.grey[100],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: expense,
                              style: kLabelStyleBold.copyWith(
                                  color: Theme.of(context).hintColor),
                            ),
                            TextSpan(
                              text: " ",
                            ),
                            TextSpan(
                              text: controller.currencySymbol.value +
                                  totalExpense.toString(),
                              style: kLabelStyle.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: income,
                              style: kLabelStyleBold.copyWith(
                                  color: Theme.of(context).hintColor),
                            ),
                            TextSpan(
                              text: " ",
                            ),
                            TextSpan(
                              text: controller.currencySymbol.value +
                                  totalIncome.toString(),
                              style: kLabelStyle.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: saving,
                              style: kLabelStyleBold.copyWith(
                                  color: Theme.of(context).hintColor),
                            ),
                            TextSpan(
                              text: " ",
                            ),
                            TextSpan(
                              text: controller.currencySymbol.value +
                                  (totalIncome - totalExpense).toString(),
                              style: kLabelStyle.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.transparent, width: 1),
                  ),
                  child: Obx(
                    () => (controller.piechartDataList.length > 0)
                        ? PieChartSample2(
                            dataList: controller.piechartDataList,
                          )
                        : Container(),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.transparent, width: 1),
                  ),
                  child: Obx(
                    () => (controller.piechartDataList.length > 0)
                        ? ListView.separated(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            separatorBuilder: (context, index) => Padding(
                                  padding: EdgeInsets.only(
                                      left: 78,
                                      bottom: kSpaceS,
                                      right: kSpaceS),
                                  child: Divider(
                                    height: 1,
                                    color: kGrey,
                                  ),
                                ),
                            itemCount: controller.piechartDataList.length +
                                ((adCont.isNativeAdReady.value &&
                                        controller.piechartDataList.length >=
                                            _kAdIndex)
                                    ? 1
                                    : 0),
                            itemBuilder: (context, index) {
                              if (adCont.isNativeAdReady.value &&
                                  index == _kAdIndex) {
                                return NativeAdView();
                              } else {
                                List<String> data = controller.piechartDataList[
                                    _getDestinationItemIndex(index)];

                                return reportTile(data);
                              }
                            })
                        : Container(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget reportTile(List<String> data) {
    return ListTile(
      onTap: () {
        controller.setCatTransactionList([]);
        Get.to(CategoryReport(
          catName: data[0],
          trType: isExpense,
        ));
      },
      title: Text(
        data[0],
        style: kLabelStyle.copyWith(color: Theme.of(context).hintColor),
      ),
      subtitle: Text(
        data[2] +
            " " +
            ((int.parse(data[2]) > 1) ? "Transactions" : transactionTab.tr),
        style: kLabelStyle.copyWith(
          color: kGrey,
          fontSize: 12,
        ),
      ),
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 40,
            width: 40,
            margin: EdgeInsets.only(bottom: 5),
            decoration: BoxDecoration(
              color: DataRepositoryImpl().iconUrl(data[0])!.colorName,
              borderRadius: BorderRadius.all(Radius.circular(25)),
            ),
            child: Icon(
              DataRepositoryImpl().iconUrl(data[0])!.iconName,
              size: 30,
              color: whiteColor,
            ),
          ),
        ],
      ),
      trailing: Text(
        currencySymbol! + "" + data[1],
        style: kLabelStyle.copyWith(
          color: (isExpense)
              ? (currentTheme.currentTheme == ThemeMode.dark)
                  ? kPink
                  : shade
              : greenbuttoncolor,
        ),
      ),
    );
  }

  Widget filterTab(String name, int index) {
    return ChoiceChip(
      label: Text(
        name,
      ),
      elevation: 0,
      selected: (tappedIndex == index),
      labelStyle: kLabelStyle.copyWith(
          fontSize: 16, color: (tappedIndex == index) ? whiteColor : darkColor),
      selectedColor: tealColor,
      backgroundColor:
          (tappedIndex == index) ? Colors.transparent : Colors.grey[100],
      onSelected: (value) {
        setState(() {
          isExpense = !isExpense;
          tappedIndex = index;
          controller.setPieChartData(controller.generateCategoryMap(
              trxList!, (index < 1) ? expense : income));
          print("index $index tappedIndex $tappedIndex");
        });
      },
    );
  }
}
