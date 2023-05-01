import 'package:budgetplanner/controllers/dashboard_controller.dart';
import 'package:budgetplanner/models/transaction_model.dart';
import 'package:budgetplanner/resources/firestore/dataRepositoryImpl.dart';
import 'package:budgetplanner/utils/PreferenceUtils.dart';
import 'package:budgetplanner/utils/app_constants.dart';
import 'package:budgetplanner/utils/category_constants.dart';
import 'package:budgetplanner/utils/controller_constants.dart';
import 'package:budgetplanner/utils/date_formatter.dart';
import 'package:budgetplanner/utils/styles.dart';
import 'package:budgetplanner/widgets/config.dart';
import 'package:budgetplanner/widgets/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'update_transaction.dart';

class TransactionCard extends StatelessWidget {
  final TransactionModel transactionModel;

  const TransactionCard({Key? key, required this.transactionModel})
      : super(key: key);
  static String currancySymbol =
      PreferenceUtils.getString(currancy_symbol, defValue: '\u20B9');
  @override
  Widget build(BuildContext context) {
    final controller = DashboardController.tagged(dashboardController);
    return InkWell(
      onTap: () {
        //open trainer detail screen
        Get.to(UpdateTransaction(transactionModel: transactionModel));
        print(transactionModel.id);
      },
      child: Column(
        children: [
          Container(
            padding:
                EdgeInsets.symmetric(horizontal: kSpaceS, vertical: kSpaceS),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.transparent, width: 0)),
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: <Widget>[
                Container(
                  width: 35.0,
                  height: 35.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    color: DataRepositoryImpl()
                        .iconUrl(transactionModel.catName!)!
                        .colorName,
                  ),
                  child: Icon(
                    DataRepositoryImpl()
                        .iconUrl(transactionModel.catName!)!
                        .iconName,
                    color: whiteColor,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: [
                            Text(
                              transactionModel.catName.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    color: Theme.of(context)
                                        .hintColor
                                        .withOpacity(.8),
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              height: 20,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(3)),
                                color: (transactionModel.transactionType ==
                                        expense)
                                    ? getTrxColor(context, transactionModel)
                                    : Theme.of(context)
                                        .hintColor
                                        .withOpacity(.08),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 0),
                                child: Text(
                                  (transactionModel.transactionType == expense)
                                      ? transactionModel.expenseSource!
                                      : income,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          color: Theme.of(context)
                                              .hintColor
                                              .withOpacity(.8)),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          transactionModel.notes ?? "",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: kGrey),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      controller.currencySymbol +
                          transactionModel.amount.toString(),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w700,
                            color: (transactionModel.transactionType == expense)
                                ? (currentTheme.currentTheme == ThemeMode.dark)
                                    ? kPink
                                    : shade
                                : greenbuttoncolor,
                          ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: Icon(
                            Icons.schedule,
                            size: 12,
                            color: Theme.of(context).hintColor.withOpacity(.8),
                          ),
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          DateFormatter().getTime(transactionModel.createdOn!),
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context)
                                      .hintColor
                                      .withOpacity(.6)),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
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
