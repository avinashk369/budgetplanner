part of budget_entry;

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
          controller.setBudgetModel(controller.catList[value]);
          controller.slidervalue.value = budgetModel.amount.toString() == 'null'
              ? 0.0
              : budgetModel.amount!.roundToDouble();
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
                            controller
                                .setBudgetModel(controller.catList[index]);
                            controller.slidervalue.value =
                                budgetModel.amount.toString() == 'null'
                                    ? 0.0
                                    : budgetModel.amount!.roundToDouble();
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
                            controller
                                .setBudgetModel(controller.catList[index]);
                            controller.slidervalue.value =
                                budgetModel.amount.toString() == 'null'
                                    ? 0.0
                                    : budgetModel.amount!.roundToDouble();
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
