part of budget_entry;

class BudgetHeader extends GetView<BudgetController> {
  const BudgetHeader({
    Key? key,
    required this.transactionController,
  }) : super(key: key);
  final TransactionEntryController transactionController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            plan_month.tr,
            style: kLabelStyle.apply(color: Theme.of(context).hintColor),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            budgetTab.tr,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          SizedBox(
            height: 10,
          ),
          Obx(
            () => Text(
              "Total budget ${controller.currencySymbol}" +
                  transactionController.getTotalBudget().toString(),
              style: kLabelStyleBold.copyWith(
                color: Theme.of(context).hintColor.withOpacity(.55),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
