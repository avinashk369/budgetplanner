import 'package:budgetplanner/models/transaction_model.dart';
import 'package:budgetplanner/resources/firestore/dataRepositoryImpl.dart';
import 'package:budgetplanner/utils/string_constants.dart';
import 'package:budgetplanner/utils/styles.dart';
import 'package:budgetplanner/widgets/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class TransactionList extends GetView {
  final List<TransactionModel> transactionModelList;
  const TransactionList(this.transactionModelList, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        //padding: EdgeInsets.zero,
        shrinkWrap: false,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: transactionModelList.length,
        separatorBuilder: (context, index) => Padding(
              padding:
                  EdgeInsets.only(left: 70, bottom: kSpaceS, right: kSpaceS),
              child: Divider(
                height: 1,
                color: kGrey,
              ),
            ),
        itemBuilder: (BuildContext context, int position) {
          TransactionModel transactionModel = transactionModelList[position];
          return InkWell(
            onTap: () {
              //open trainer detail screen
              print(transactionModel.catName);
            },
            child: Container(
              padding:
                  EdgeInsets.symmetric(horizontal: kSpaceS, vertical: kSpaceS),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.transparent, width: 0)),
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: <Widget>[
                  Container(
                    width: 60.0,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: DataRepositoryImpl()
                          .iconUrl(transactionModel.catName!)!
                          .colorName,
                    ),
                    child: Icon(
                      DataRepositoryImpl()
                          .iconUrl(transactionModel.catName!)!
                          .iconName,
                      color: Theme.of(context).hintColor,
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
                            transactionModel.expenseType!,
                          )
                        ],
                      ),
                    ),
                  ),
                  Text(
                    "\u20B9 " + transactionModel.amount.toString(),
                    style: kLabelStyle.apply(
                      fontSizeFactor: 1.2,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
