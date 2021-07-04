import 'package:budgetplanner/ad/native_ad.dart';
import 'package:budgetplanner/controllers/ad_controller.dart';
import 'package:budgetplanner/models/budget_model.dart';
import 'package:budgetplanner/models/transaction_model.dart';
import 'package:budgetplanner/screens/bottom_nav/pages/budget/budget_card.dart';
import 'package:budgetplanner/screens/bottom_nav/pages/transaction/transaction_card.dart';
import 'package:budgetplanner/utils/controller_constants.dart';
import 'package:budgetplanner/widgets/theme_constants.dart';
import 'package:flutter/material.dart';

class RecentTransaction extends StatefulWidget {
  final List<TransactionModel> transactionModelList;
  RecentTransaction({required this.transactionModelList});
  @override
  _RecentTransactionState createState() => _RecentTransactionState();
}

class _RecentTransactionState extends State<RecentTransaction> {
  final controller = AdController.tagged(adController);

  static final _kAdIndex = 4;
  int _getDestinationItemIndex(int rawIndex) {
    if (rawIndex >= _kAdIndex && controller.isNativeAdReady.value) {
      return rawIndex - 1;
    }
    return rawIndex;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: widget.transactionModelList.length +
            (controller.isNativeAdReady.value ? 1 : 0),
        separatorBuilder: (context, index) => Padding(
              padding:
                  EdgeInsets.only(left: 70, bottom: kSpaceS, right: kSpaceS),
              child: Divider(
                height: 1,
                color: kGrey,
              ),
            ),
        itemBuilder: (BuildContext context, int position) {
          if (controller.isNativeAdReady.value && position == _kAdIndex) {
            return NativeAdView();
          } else {
            TransactionModel transactionModel =
                widget.transactionModelList[_getDestinationItemIndex(position)];
            return Padding(
                padding: EdgeInsets.all(5),
                child: TransactionCard(
                  transactionModel: transactionModel,
                ));
          }
        });
  }
}
