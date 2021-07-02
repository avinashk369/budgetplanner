import 'package:budgetplanner/screens/bottom_nav/pages/settings/language_data.dart';
import 'package:budgetplanner/utils/styles.dart';
import 'package:budgetplanner/widgets/theme_constants.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CurrencyScreen extends StatelessWidget {
  const CurrencyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0),
      body: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: kSpaceS, vertical: kSpaceM),
          child: CustomScrollView(
            //controller: ScrollController(),
            physics: BouncingScrollPhysics(),
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 8),
                      height: Get.height * .15,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Configure your regional",
                            style: kLabelStyle.apply(
                                color: Theme.of(context).hintColor),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Currency",
                            style: kTitleStyle,
                          )
                        ],
                      ),
                    ),
                    //BudgetCard()
                  ],
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
