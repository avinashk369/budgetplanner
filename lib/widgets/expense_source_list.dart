import 'package:budgetplanner/models/expense_source_model.dart';
import 'package:budgetplanner/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import 'theme_constants.dart';

class ExpenseSourceList extends GetView {
  final List<ExpenseSourceModel> expenseSourceList;
  final Function(ExpenseSourceModel rexpenseSourceModel) iconClicked;
  ExpenseSourceList(this.expenseSourceList, this.iconClicked);
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: expenseSourceList.length,
        separatorBuilder: (context, index) => Padding(
              padding:
                  EdgeInsets.only(left: 10, bottom: kSpaceS, right: kSpaceS),
              child: Divider(
                height: 1,
                color: kGrey,
              ),
            ),
        itemBuilder: (BuildContext context, int position) {
          ExpenseSourceModel expSourceModel = expenseSourceList[position];
          return InkWell(
            onTap: () {
              iconClicked(expSourceModel);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.transparent, width: 0)),
              width: MediaQuery.of(context).size.width,
              child: Text(
                expSourceModel.name.toString(),
                style: kLabelStyle.apply(
                  fontSizeFactor: 1.2,
                  color: Theme.of(context).hintColor,
                ),
              ),
            ),
          );
        });
  }
}
