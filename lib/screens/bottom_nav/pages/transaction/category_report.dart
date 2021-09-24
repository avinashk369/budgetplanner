import 'package:budgetplanner/ad/banner_ad.dart';
import 'package:budgetplanner/controllers/transaction_controller.dart';
import 'package:budgetplanner/models/transaction_model.dart';
import 'package:budgetplanner/resources/firestore/dataRepositoryImpl.dart';
import 'package:budgetplanner/screens/bottom_nav/pages/transaction/category_bar_chart.dart';
import 'package:budgetplanner/utils/PreferenceUtils.dart';
import 'package:budgetplanner/utils/app_constants.dart';
import 'package:budgetplanner/utils/category_constants.dart';
import 'package:budgetplanner/utils/date_formatter.dart';
import 'package:budgetplanner/utils/styles.dart';
import 'package:budgetplanner/widgets/config.dart';
import 'package:budgetplanner/widgets/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class CategoryReport extends StatefulWidget {
  final String catName;
  final bool trType;

  const CategoryReport({Key? key, required this.catName, required this.trType})
      : super(key: key);

  @override
  _CategoryReportState createState() => _CategoryReportState();
}

class _CategoryReportState extends State<CategoryReport> {
  final controller = TransactionEntryController.to;
  String? currencySymbol;
  var date = DateTime.now();
  double totalAmount = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currencySymbol =
        PreferenceUtils.getString(currancy_symbol, defValue: '\u20B9');
    () async {
      // controller.catTransactionModel.value = (await controller
      //     .getAllTransactionOfYearForCategory(date.year, widget.catName))!;
      print(widget.catName);
      controller.setCatTransactionList((await controller
          .getAllTransactionOfYearForCategory(date.year, widget.catName))!);
      controller.catTransactionList.forEach((element) {
        setState(() {
          totalAmount += element.amount!;
        });
      });
    }();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Container(
          width: 40.0,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: DataRepositoryImpl().iconUrl(widget.catName)!.colorName,
          ),
          child: Icon(
            DataRepositoryImpl().iconUrl(widget.catName)!.iconName,
            color: whiteColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(() {
              if (controller.catTransactionList.isNotEmpty) {
                print("actual ${controller.catTransactionList.length}");
                return CategoryBarChart(
                  transactionList: controller.catTransactionList,
                  totalExp: totalAmount,
                );
              } else {
                return Container();
              }
            }),
            SizedBox(
              height: 15,
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
                        border: Border.all(color: Colors.transparent, width: 1),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: Color(0xff64caad), //grey[100]
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: widget.trType
                                  ? "Total expenses "
                                  : "Total incomes ",
                              style: kLabelStyleBold.copyWith(
                                  color: Theme.of(context).hintColor)),
                          TextSpan(
                              text: totalAmount.toString(),
                              style: kLabelStyle.copyWith(
                                  color: Theme.of(context).hintColor))
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            BannerAdView(),
            SizedBox(
              height: 15,
            ),
            Obx(
              () => (controller.catTransactionList.isNotEmpty)
                  ? renderList(controller.catTransactionList)
                  : Container(),
            ),
          ],
        ),
      ),
    );
  }

  Widget renderList(List<TransactionModel> trxList) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: trxList.length,
      separatorBuilder: (context, index) => Padding(
        padding: EdgeInsets.only(left: 15, bottom: kSpaceS, right: kSpaceS),
        child: Divider(
          height: 1,
          color: kGrey,
        ),
      ),
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            trxList[index].notes!,
            style: kLabelStyle.copyWith(
                fontSize: 15, color: Theme.of(context).hintColor),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 5,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                height: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: (trxList[index].transactionType == expense)
                      ? getTrxColor(context, trxList[index])
                      : Theme.of(context).hintColor.withOpacity(.08),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      (trxList[index].transactionType == expense)
                          ? trxList[index].expenseSource!
                          : income,
                      style: kLabelStyle.copyWith(
                        color: (trxList[index].transactionType == expense)
                            ? Colors.black
                            : Theme.of(context).hintColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 15,
                        color: Theme.of(context).hintColor.withOpacity(.8),
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        DateFormatter().getDate(trxList[index].createdOn!),
                        style: kLabelStyle.copyWith(
                            fontSize: 13,
                            color: Theme.of(context).hintColor.withOpacity(.8)),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      children: [
                        Icon(
                          Icons.schedule,
                          size: 15,
                          color: Theme.of(context).hintColor.withOpacity(.8),
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          DateFormatter().getTime(trxList[index].createdOn!),
                          style: kLabelStyle.copyWith(
                              fontSize: 13,
                              color:
                                  Theme.of(context).hintColor.withOpacity(.8)),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
            ],
          ),
          trailing: Text(
            currencySymbol! + "" + trxList[index].amount.toString(),
            style: kLabelStyle.copyWith(
              color:
                  (currentTheme.currentTheme == ThemeMode.dark) ? kPink : shade,
            ),
          ),
        );
      },
    );
  }

  Color getTrxColor(BuildContext context, TransactionModel transactionModel) {
    switch (transactionModel.expenseSource) {
      case creditCard:
        return Colors.indigo[100]!;
      case accounts:
        return Colors.greenAccent;
      case cash:
        return Colors.orange[100]!;
      default:
        return Theme.of(context).hintColor;
    }
  }
}
