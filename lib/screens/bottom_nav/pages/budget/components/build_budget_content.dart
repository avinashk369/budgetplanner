import 'package:budgetplanner/controllers/budget_controller.dart';
import 'package:budgetplanner/models/budget_category_model.dart';
import 'package:budgetplanner/models/budget_model.dart';
import 'package:budgetplanner/resources/firestore/dataRepositoryImpl.dart';
import 'package:budgetplanner/utils/styles.dart';
import 'package:budgetplanner/widgets/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuildBudgetContent extends GetView<BudgetController> {
  const BuildBudgetContent({
    Key? key,
    required this.move,
    required this.budgetCategoryModel,
    required this.budgetModel,
  }) : super(key: key);
  final BudgetCategoryModel budgetCategoryModel;
  final Function(BudgetModel budgetModel) move;
  final BudgetModel budgetModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => move(budgetModel),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
        child: budgetCard(budgetCategoryModel, budgetModel),
      ),
    );
  }

  Widget budgetCard(
          BudgetCategoryModel budgetCategoryModel, BudgetModel budgetModel) =>
      Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: DataRepositoryImpl()
            .iconUrl(budgetCategoryModel.name!)!
            .colorName
            .withOpacity(.5),
        child: content(budgetCategoryModel, budgetModel),
      );

  Widget content(
          BudgetCategoryModel budgetCategoryModel, BudgetModel budgetModel) =>
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: DataRepositoryImpl()
                        .iconUrl(budgetCategoryModel.name!)!
                        .colorName,
                  ),
                  child: Icon(
                    DataRepositoryImpl()
                        .iconUrl(budgetCategoryModel.name!)!
                        .iconName,
                    color: whiteColor,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      budgetCategoryModel.name!,
                      style: kLabelStyleBold,
                    ),
                    Text(
                      budgetModel.amount.toString() == "null"
                          ? controller.currencySymbol + "0.0"
                          : controller.currencySymbol +
                              budgetModel.amount.toString(),
                      style: kLabelStyle,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
