import 'package:budgetplanner/models/recurrance_model.dart';
import 'package:budgetplanner/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import 'theme_constants.dart';

class RecurranceList extends GetView {
  final List<RecurranceModel> recurranceList;
  final Function(RecurranceModel recurranceModel) iconClicked;
  RecurranceList(this.recurranceList, this.iconClicked);
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: recurranceList.length,
        separatorBuilder: (context, index) => Padding(
              padding:
                  EdgeInsets.only(left: 10, bottom: kSpaceS, right: kSpaceS),
              child: Divider(
                height: 1,
                color: kGrey,
              ),
            ),
        itemBuilder: (BuildContext context, int position) {
          RecurranceModel recurrance = recurranceList[position];
          return InkWell(
            onTap: () {
              iconClicked(recurrance);
              //open trainer detail screen
              //print(recurrance.name);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.transparent, width: 0)),
              width: MediaQuery.of(context).size.width,
              child: Text(
                recurrance.name.toString(),
                style: kLabelStyle.apply(
                  fontSizeFactor: 1.2,
                  color: darkColor,
                ),
              ),
            ),
          );
        });
  }
}
