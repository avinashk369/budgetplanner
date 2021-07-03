import 'package:budgetplanner/controllers/dashboard_controller.dart';
import 'package:budgetplanner/models/transaction_model.dart';
import 'package:budgetplanner/resources/firestore/dataRepositoryImpl.dart';
import 'package:budgetplanner/utils/PreferenceUtils.dart';
import 'package:budgetplanner/utils/app_constants.dart';
import 'package:budgetplanner/utils/category_constants.dart';
import 'package:budgetplanner/utils/controller_constants.dart';
import 'package:budgetplanner/utils/styles.dart';
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
                  width: 50.0,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
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
                        Text(
                          transactionModel.catName.toString(),
                          style: kLabelStyle.apply(
                              fontSizeFactor: 1.2,
                              color: Theme.of(context).hintColor),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          transactionModel.notes ?? "",
                          style: kLabelStyle.apply(
                            color: kGrey,
                          ),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          (transactionModel.transactionType == expense)
                              ? transactionModel.expenseType ?? ""
                              : income,
                        )
                      ],
                    ),
                  ),
                ),
                Text(
                  controller.currencySymbol +
                      transactionModel.amount.toString(),
                  style: kLabelStyle.apply(
                    fontSizeFactor: 1.2,
                    color: (transactionModel.transactionType == expense)
                        ? kPink
                        : greenbuttoncolor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
