import 'package:budgetplanner/controllers/budget_controller.dart';
import 'package:budgetplanner/models/budget_model.dart';
import 'package:budgetplanner/screens/bottom_nav/pages/budget/components/build_budget_content.dart';
import 'package:budgetplanner/screens/bottom_nav/pages/budget/components/build_budget_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BudgetCatList extends StatelessWidget {
  const BudgetCatList(
      {Key? key, required this.budget, required this.budgetList})
      : super(key: key);
  final BudgetController budget;
  final List<BudgetModel> budgetList;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * .1,
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: PageView.builder(
        scrollDirection: Axis.horizontal,
        padEnds: false,
        controller: budget.pageController,
        itemCount: budget.catList.length + 1,
        onPageChanged: (value) {
          budget.currentIndex.value = value;
          BudgetModel budgetModel = BudgetModel();

          for (BudgetModel bm in budgetList) {
            if (bm.catName == budget.catList[value].name) {
              budgetModel = bm;
            }
          }
          budget.setBudget(budgetModel);
        },
        itemBuilder: (context, index) {
          BudgetModel budgetModel = BudgetModel();
          if (index < budget.catList.length) {
            for (BudgetModel bm in budgetList) {
              if (bm.catName == budget.catList[index].name) budgetModel = bm;
            }
          }
          return index < budget.catList.length
              ? Obx(
                  () => budget.currentIndex.value == index
                      ? BuildBudgetContent(
                          move: (bm) {
                            budget.setBudget(bm);
                          },
                          budgetCategoryModel: budget.catList[index],
                          budgetModel: budgetModel,
                        )
                      : BudgetIcon(
                          move: (bm) {
                            budget.setBudget(bm);
                            print(
                                "Kumar ${budget.budgetDetail.value.toJson()}");
                            budget.pageController.animateToPage(
                                budget.currentIndex.value ==
                                        budget.catList.length
                                    ? budget.currentIndex.value
                                    : budget.currentIndex.value + 1,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease);
                          },
                          budgetCategoryModel: budget.catList[index],
                          budgetModel: budgetModel,
                        ),
                )
              : SizedBox();
        },
      ),
    );
  }
}
