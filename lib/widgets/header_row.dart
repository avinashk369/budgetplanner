import 'package:budgetplanner/controllers/dashboard_controller.dart';
import 'package:budgetplanner/controllers/transaction_controller.dart';
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
import 'package:google_fonts/google_fonts.dart';
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(),
                      Text(
                        DateFormat('LLL').format(DateTime.now()) +
                            " " +
                            DateFormat('d').format(DateTime.now()),
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        total_balance.tr.toUpperCase(),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).hintColor.withOpacity(.8),
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                          controller.currencySymbol +
                              (income - expense).toString(),
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: ((income - expense) > 0)
                                        ? greenbuttoncolor
                                        : redColor,
                                  )),
                      const Spacer(),
                      Container(
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  total_income.tr.toUpperCase(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          color: darkColor.withOpacity(.8),
                                          fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  controller.currencySymbol + income.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: greenbuttoncolor,
                                      ),
                                )
                              ],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 1,
                              height: 30,
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
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          color: darkColor.withOpacity(.8),
                                          fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  controller.currencySymbol +
                                      expense.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: redColor,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Spacer(),
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge!
                                          .copyWith(
                                              fontWeight: FontWeight.w700),
                                    ),
                                    TextSpan(
                                        text: '%',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium!
                                            .copyWith(
                                                fontWeight: FontWeight.w700,
                                                color: shade)),
                                  ],
                                ),
                              )
                            ],
                          );
                        },
                        appearance: CircularSliderAppearance(
                            size: Get.height * .18,
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
                    const Spacer(),
                    ChoiceChip(
                      label: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "View report >",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: Theme.of(context)
                                          .hintColor
                                          .withOpacity(.8)),
                            ),
                          ],
                        ),
                      ),
                      onSelected: (value) {
                        Get.to(TransactionReport());
                      },
                      avatar: Icon(
                        EvaIcons.barChart,
                        color: Theme.of(context).colorScheme.secondary,
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

  Widget balanceCOntainer(
          BuildContext context, DashboardController controller) =>
      Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Stack(
          children: [
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  color: Colors.deepPurpleAccent,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          total_expense.tr.toUpperCase(),
                          style: kLabelStyleBold.copyWith(
                              color: Theme.of(context).hintColor, fontSize: 12),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          controller.currencySymbol + expense.toString(),
                          style: kLabelStyleBold.copyWith(
                            color: redColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
            ClipPath(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  color: Colors.greenAccent,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      total_income.tr.toUpperCase(),
                      style: kLabelStyleBold.copyWith(
                          color: Theme.of(context).hintColor, fontSize: 12),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      controller.currencySymbol + income.toString(),
                      style: kLabelStyleBold.copyWith(
                        color: greenbuttoncolor,
                      ),
                    )
                  ],
                ),
              ),
              clipper: CustomClipPath(),
            )
          ],
        ),
      );
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, 80);
    path.lineTo(80, 80);
    path.lineTo(120, 0);
    path.lineTo(30, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
