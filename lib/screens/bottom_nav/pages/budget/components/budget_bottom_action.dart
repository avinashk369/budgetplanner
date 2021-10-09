part of budget_entry;

class BudgetBottom extends GetView<BudgetController> {
  const BudgetBottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 15),
      child: SizedBox(
        height: Get.height * .6 - 93,
        child: Container(
          decoration: BoxDecoration(
            color: CustomTheme().currentTheme == ThemeMode.dark
                ? Colors.black26
                : Colors.grey[100],
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Spacer(),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 25),
              //   child: Obx(
              //     () => Text(
              //       controller.budgetDetail.value.amount.toString() == 'null'
              //           ? controller.currencySymbol + '0.0'
              //           : controller.currencySymbol +
              //               controller.budgetDetail.value.amount.toString(),
              //       style: kLabelStyleBold.copyWith(fontSize: 30),
              //     ),
              //   ),
              // ),
              // Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: BudgetInput(),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Obx(
                  () => controller.message.isNotEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.message.keys.first,
                              style: kLabelStyleBold.copyWith(
                                fontSize: 20,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              controller.message.values.first,
                              style: kLabelStyle.copyWith(
                                color: Theme.of(context).hintColor,
                              ),
                            )
                          ],
                        )
                      : SizedBox(),
                ),
              ),
              Spacer(),
              Center(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    primary: Theme.of(context).hintColor,
                  ),
                  child: Text(
                    "Submit",
                  ),
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
