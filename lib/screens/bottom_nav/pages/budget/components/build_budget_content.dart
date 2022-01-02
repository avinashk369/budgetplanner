part of budget_entry;

class BuildBudgetContent extends GetView<BudgetController> {
  const BuildBudgetContent({
    Key? key,
    required this.move,
    required this.budgetCategoryModel,
    required this.budgetModel,
  }) : super(key: key);
  final BudgetCategoryModel budgetCategoryModel;
  final Function move;
  final BudgetModel budgetModel;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      controller.setBudgetModel(budgetCategoryModel);
      if (budgetModel.catName != null) {
        controller.setBudget(budgetModel);
        // controller.amountController.text =
        //     budgetModel.amount.toString() == 'null'
        //         ? '0.0'
        //         : budgetModel.amount.toString();
        controller.slidervalue.value =
            budgetModel.amount! > 0 ? budgetModel.amount!.roundToDouble() : 0.0;

        controller.message.value =
            BudgetMessage.getBudgetMessage(budgetModel.amount!);
      } else {
        // controller.amountController.text = '0.0';
        controller.slidervalue.value = 0.0;
        controller.message.value = BudgetMessage.getBudgetMessage(0.0);
      }
    });

    return InkWell(
      onTap: () => move(),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
        child: budgetCard(context, budgetCategoryModel, budgetModel),
      ),
    );
  }

  Widget budgetCard(BuildContext context,
          BudgetCategoryModel budgetCategoryModel, BudgetModel budgetModel) =>
      Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: DataRepositoryImpl()
            .iconUrl(budgetCategoryModel.name!)!
            .colorName
            .withOpacity(.6),
        child: content(context, budgetCategoryModel, budgetModel),
      );

  Widget content(BuildContext context, BudgetCategoryModel budgetCategoryModel,
          BudgetModel budgetModel) =>
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
                      style: kLabelStyleBold.copyWith(
                          color: Theme.of(context).hintColor),
                    ),
                    Text(
                      budgetModel.amount.toString() == "null"
                          ? controller.currencySymbol + "0.0"
                          : controller.currencySymbol +
                              budgetModel.amount.toString(),
                      style: kLabelStyle.copyWith(
                          color: Theme.of(context).hintColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
