part of budget_entry;

class BudgetHeader extends GetView<BudgetController> {
  const BudgetHeader({
    Key? key,
    required this.transactionController,
  }) : super(key: key);
  final TransactionEntryController transactionController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * .3,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Set up a monthly",
              style: kLabelStyleBold.copyWith(
                  fontSize: 20, color: Theme.of(context).hintColor),
            ),
            Text(
              "budget goal",
              style: Theme.of(context).textTheme.headline1,
            ),
            SizedBox(
              height: 15,
            ),
            Obx(
              () => Text(
                "Total budget ${controller.currencySymbol}" +
                    transactionController.getTotalBudget().toString(),
                style: kLabelStyleBold.copyWith(
                  color: Theme.of(context).hintColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
