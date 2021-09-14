import 'package:budgetplanner/controllers/dashboard_controller.dart';
import 'package:budgetplanner/controllers/transaction_controller.dart';
import 'package:budgetplanner/screens/bottom_nav/pages/transaction/BarChartSample5.dart';
import 'package:budgetplanner/screens/bottom_nav/pages/transaction/transaction_report.dart';
import 'package:budgetplanner/utils/PreferenceUtils.dart';
import 'package:budgetplanner/utils/app_constants.dart';
import 'package:budgetplanner/utils/controller_constants.dart';
import 'package:budgetplanner/utils/mathUtils.dart';
import 'package:budgetplanner/utils/string_constants.dart';
import 'package:budgetplanner/utils/styles.dart';
import 'package:budgetplanner/widgets/theme_constants.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import 'custom_theme.dart';

class HeaderRow extends StatelessWidget {
  final double income, expense;
  const HeaderRow({
    Key? key,
    this.income = 0.0,
    this.expense = 0.0,
  }) : super(key: key);
  static String currancySymbol =
      PreferenceUtils.getString(currancy_symbol, defValue: '\u20B9');
  @override
  Widget build(BuildContext context) {
    final transactionController = TransactionEntryController.to;
    final controller = DashboardController.tagged(dashboardController);
    //print("print val ${transactionController.totalExpense.value}");
    return Stack(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            width: Get.width,
            height: Get.height,
            margin: EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Flexible(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat('LLL').format(DateTime.now()) +
                            " " +
                            DateFormat('d').format(DateTime.now()),
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        total_balance.tr.toUpperCase(),
                        style: kLabelStyleBold.apply(
                            color: Theme.of(context).hintColor),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(controller.currencySymbol +
                          (income - expense).toString()),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  total_income.tr.toUpperCase(),
                                  style: kLabelStyleBold.apply(
                                      color: Theme.of(context).hintColor),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(controller.currencySymbol +
                                    income.toString())
                              ],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 1,
                              height: 40,
                              color:
                                  (CustomTheme().currentTheme == ThemeMode.dark)
                                      ? Colors.black26
                                      : Colors.grey[300],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  total_expense.tr.toUpperCase(),
                                  style: kLabelStyleBold.apply(
                                      color: Theme.of(context).hintColor),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(controller.currencySymbol +
                                    expense.toString()),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 0),
                      child: SleekCircularSlider(
                        innerWidget: (percentage) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: MathUtils.getPercentage(
                                              income, expense)
                                          .toString(),
                                      style:
                                          Theme.of(context).textTheme.headline1,
                                    ),
                                    TextSpan(
                                        text: '%',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline2),
                                  ],
                                ),
                              )
                            ],
                          );
                        },
                        appearance: CircularSliderAppearance(
                            size: Get.height * .20,
                            startAngle: 280,
                            angleRange: 350,
                            customColors: CustomSliderColors(
                              dotColor: kWhite,
                              progressBarColor:
                                  (MathUtils.getPercentage(income, expense) >
                                          80)
                                      ? redColor
                                      : greenbuttoncolor,
                              trackColor: kGrey,
                            ),
                            customWidths: CustomSliderWidths(
                              progressBarWidth: Get.height * .01,
                            )),
                        min: 0,
                        max: 100,
                        initialValue: (MathUtils.getPercentage(income, expense)
                                    .toDouble() >
                                100)
                            ? 100
                            : MathUtils.getPercentage(income, expense)
                                .toDouble(),
                        onChangeStart: (value) {},
                      ),
                    ),
                    ChoiceChip(
                      label: RichText(
                          text: TextSpan(children: [
                        TextSpan(
                          text: "View report ",
                          style: kLabelStyle.copyWith(
                              fontSize: 14, color: Theme.of(context).hintColor),
                        ),
                        TextSpan(
                          text: ">",
                          style: kLabelStyle.copyWith(
                              fontSize: 14, color: Theme.of(context).hintColor),
                        ),
                      ])),
                      onSelected: (value) {
                        Get.to(TransactionReport());
                      },
                      avatar: Icon(
                        EvaIcons.barChart,
                        color: Theme.of(context).accentColor,
                      ),
                      selected: true,
                      selectedColor:
                          CustomTheme().currentTheme == ThemeMode.dark
                              ? kDarkGrey
                              : Colors.grey[100],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
