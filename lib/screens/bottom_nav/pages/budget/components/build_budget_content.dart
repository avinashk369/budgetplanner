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
  _renderMessage(String val) {
    int value = double.parse(val).toInt();
    print("${val.isEmpty} less than zero $value");

    if (value < 1) {
      print("less than zero");
      controller.message.value = controller.getMessage("Normal");
    }
    if (value > 3000 && value < 4000) {
      print("3000");
      controller.message.value = controller.getMessage("Standard");
    }
    if (value > 4000) {
      print("5000");
      controller.message.value = controller.getMessage("Hyper");
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (budgetModel.catName != null) {
        controller.setBudget(budgetModel);
        controller.amountController.text =
            budgetModel.amount.toString() == 'null'
                ? '0.0'
                : budgetModel.amount.toString();
        controller.message.value = controller.getMessage("Normal");
      } else {
        controller.amountController.text = '0.0';
      }
      _renderMessage(controller.amountController.text);
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
