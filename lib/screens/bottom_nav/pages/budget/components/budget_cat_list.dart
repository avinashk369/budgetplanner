import 'package:budgetplanner/controllers/budget_controller.dart';
import 'package:budgetplanner/models/budget_model.dart';
import 'package:budgetplanner/screens/bottom_nav/pages/budget/components/build_budget_content.dart';
import 'package:budgetplanner/screens/bottom_nav/pages/budget/components/build_budget_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BudgetCatList extends GetView<BudgetController> {
  const BudgetCatList({Key? key, required this.budgetList}) : super(key: key);
  final List<BudgetModel> budgetList;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * .1,
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: PageView.builder(
        scrollDirection: Axis.horizontal,
        padEnds: false,
        controller: controller.pageController,
        itemCount: controller.catList.length + 1,
        onPageChanged: (value) {
          controller.currentIndex.value = value;
          BudgetModel budgetModel = BudgetModel();

          for (BudgetModel bm in budgetList) {
            if (bm.catName == controller.catList[value].name) {
              budgetModel = bm;
            }
          }
          controller.setBudget(budgetModel);
        },
        itemBuilder: (context, index) {
          BudgetModel budgetModel = BudgetModel();

          if (index < controller.catList.length) {
            for (BudgetModel bm in budgetList) {
              if (bm.catName == controller.catList[index].name) {
                budgetModel = bm;
              }
            }
          }
          return index < controller.catList.length
              ? Obx(
                  () => controller.currentIndex.value == index
                      ? BuildBudgetContent(
                          move: () {
                            controller.setBudget(budgetModel);
                          },
                          budgetCategoryModel: controller.catList[index],
                          budgetModel: budgetModel,
                        )
                      : BudgetIcon(
                          move: () {
                            controller.pageController.animateToPage(
                                controller.currentIndex.value ==
                                        controller.catList.length
                                    ? controller.currentIndex.value
                                    : controller.currentIndex.value + 1,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease);
                            controller.setBudget(budgetModel);

                            print(
                                "Kumar ${controller.budgetDetail.value.toJson()}");
                          },
                          budgetCategoryModel: controller.catList[index],
                          budgetModel: budgetModel,
                        ),
                )
              : SizedBox();
        },
      ),
    );
  }
}
