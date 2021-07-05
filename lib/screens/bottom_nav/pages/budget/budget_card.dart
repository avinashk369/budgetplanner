import 'package:budgetplanner/controllers/dashboard_controller.dart';
import 'package:budgetplanner/models/budget_model.dart';
import 'package:budgetplanner/resources/firestore/dataRepositoryImpl.dart';
import 'package:budgetplanner/screens/bottom_nav/pages/budget/update_budget.dart';
import 'package:budgetplanner/utils/PreferenceUtils.dart';
import 'package:budgetplanner/utils/app_constants.dart';
import 'package:budgetplanner/utils/controller_constants.dart';
import 'package:budgetplanner/utils/mathUtils.dart';
import 'package:budgetplanner/utils/styles.dart';
import 'package:budgetplanner/widgets/config.dart';
import 'package:budgetplanner/widgets/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class BudgetCard extends StatelessWidget {
  final BudgetModel budgetModel;
  const BudgetCard({Key? key, required this.budgetModel}) : super(key: key);
  static String currancySymbol =
      PreferenceUtils.getString(currancy_symbol, defValue: '\u20B9');

  @override
  Widget build(BuildContext context) {
    final controller = DashboardController.tagged(dashboardController);

    return InkWell(
      onTap: () {
        //open trainer detail screen
        Get.to(UpdateBudget(budgetModel: budgetModel));
        print(budgetModel.id);
      },
      child: Container(
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
              child: Obx(
                () => SleekCircularSlider(
                  key: Key("fasting_progress"),
                  innerWidget: (percentage) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: MathUtils.getPercentage(
                                        budgetModel.amount!,
                                        budgetModel.totalBudgetExpense.value)
                                    .toString(),
                                style: kTitleStyle.copyWith(
                                    color: (currentTheme.currentTheme ==
                                            ThemeMode.dark)
                                        ? shade
                                        : kPink),
                              ),
                              TextSpan(
                                  text: '%',
                                  style: kTitleStyleSmall.copyWith(
                                      color: (currentTheme.currentTheme ==
                                              ThemeMode.dark)
                                          ? shade
                                          : kPink)),
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
                        progressBarColor: (MathUtils.getPercentage(
                                    budgetModel.amount!,
                                    budgetModel.totalBudgetExpense.value) >
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
                  initialValue: (MathUtils.getPercentage(budgetModel.amount!,
                                  budgetModel.totalBudgetExpense.value)
                              .toDouble() >
                          100)
                      ? 100
                      : MathUtils.getPercentage(budgetModel.amount!,
                              budgetModel.totalBudgetExpense.value)
                          .toDouble(),
                  onChangeStart: (value) {},
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 5,
                vertical: 5,
              ),
              child: Text(
                budgetModel.catName!,
                style: kLabelStyleBold.apply(
                    color: Theme.of(context).primaryColor),
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
                            controller.currencySymbol +
                                budgetModel.amount.toString(),
                            style: kLabelStyle.apply(
                                color: Theme.of(context).primaryColor),
                          ),
                          Obx(() => Text(
                                controller.currencySymbol +
                                    budgetModel.totalBudgetExpense.value
                                        .toString(),
                                style: kLabelStyle.apply(
                                    color: Theme.of(context).primaryColor),
                              )),
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
      ),
    );
  }
}
