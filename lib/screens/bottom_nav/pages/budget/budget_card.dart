import 'package:budgetplanner/models/budget_model.dart';
import 'package:budgetplanner/resources/firestore/dataRepositoryImpl.dart';
import 'package:budgetplanner/utils/styles.dart';
import 'package:budgetplanner/widgets/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class BudgetCard extends StatelessWidget {
  final BudgetModel budgetModel;
  const BudgetCard({Key? key, required this.budgetModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.height * .22,
      height: Get.height * .27,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        color: Theme.of(context).hintColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Center(
            child: SleekCircularSlider(
              key: Key("fasting_progress"),
              innerWidget: (percentage) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '100',
                            style: kTitleStyle,
                          ),
                          TextSpan(text: '%', style: kTitleStyleSmall),
                        ],
                      ),
                    )
                  ],
                );
              },
              appearance: CircularSliderAppearance(
                  size: Get.height * .16,
                  startAngle: 280,
                  angleRange: 350,
                  customColors: CustomSliderColors(
                    dotColor: kWhite,
                    progressBarColor: Colors.green,
                    trackColor: kGrey,
                  ),
                  customWidths: CustomSliderWidths(
                    progressBarWidth: Get.height * .01,
                  )),
              min: 0,
              max: 80,
              initialValue: 50,
              onChangeStart: (value) {},
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 5,
              vertical: 5,
            ),
            child: Text(
              budgetModel.catName!,
              style: kLabelStyleBold,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(5, 0, 5, 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "\u20B9" + budgetModel.amount.toString(),
                          style: kLabelStyle,
                        ),
                        Text(
                          "\u20B9" + "50000 ",
                          style: kLabelStyle,
                        ),
                      ],
                    )),
                Container(
                  width: 40.0,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: DataRepositoryImpl()
                        .iconUrl(budgetModel.catName!)!
                        .colorName,
                  ),
                  child: Icon(
                    DataRepositoryImpl()
                        .iconUrl(budgetModel.catName!)!
                        .iconName,
                    color: whiteColor,
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
