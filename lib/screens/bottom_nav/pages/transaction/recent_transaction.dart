import 'package:budgetplanner/models/budget_model.dart';
import 'package:budgetplanner/models/transaction_model.dart';
import 'package:budgetplanner/screens/bottom_nav/pages/budget/budget_card.dart';
import 'package:budgetplanner/screens/bottom_nav/pages/transaction/transaction_card.dart';
import 'package:budgetplanner/widgets/theme_constants.dart';
import 'package:flutter/material.dart';

class RecentTransaction extends StatefulWidget {
  final List<TransactionModel>? transactionModelList;
  RecentTransaction({this.transactionModelList});
  @override
  _RecentTransactionState createState() => _RecentTransactionState();
}

class _RecentTransactionState extends State<RecentTransaction> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        //padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: 5,
        separatorBuilder: (context, index) => Padding(
              padding:
                  EdgeInsets.only(left: 70, bottom: kSpaceS, right: kSpaceS),
              child: Divider(
                height: 1,
                color: kGrey,
              ),
            ),
        itemBuilder: (BuildContext context, int position) {
          //TransactionModel transactionModel = transactionModelList[position];
          TransactionModel transactionModel = TransactionModel();
          transactionModel.catName = "Others";
          transactionModel.amount = 220;
          transactionModel.notes = "Demo";
          transactionModel.transactionType = "Income";
          return Padding(
              padding: EdgeInsets.all(5),
              child: TransactionCard(
                transactionModel: transactionModel,
              ));
        });
  }
}
