part of budget_entry;

class BudgetBottom extends GetView<BudgetController> {
  const BudgetBottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 15),
      child: SizedBox(
        height: Get.height * .5,
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                      () => Text(
                        controller.budgetDetail.value.catName != null
                            ? controller.isSliding()
                                ? controller.currencySymbol +
                                    controller.slidervalue.value
                                        .roundToDouble()
                                        .toString()
                                : controller.currencySymbol +
                                    controller.budgetDetail.value.amount
                                        .toString()
                            : controller.currencySymbol +
                                controller.slidervalue.value
                                    .roundToDouble()
                                    .toString(),
                        style: kLabelStyleBold.copyWith(
                            fontSize: 30, color: Theme.of(context).hintColor),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          controller.amountController.text =
                              controller.budgetDetail.value.catName != null
                                  ? controller.slidervalue.value > 1
                                      ? controller.slidervalue.value
                                          .roundToDouble()
                                          .toString()
                                      : controller.budgetDetail.value.amount
                                          .toString()
                                  : controller.slidervalue.value
                                      .roundToDouble()
                                      .toString();
                          showEditBudgetSheet(context);
                        },
                        icon: Icon(Icons.edit))
                  ],
                ),
              ),
              Spacer(),
              BudgetSlider(),
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

  showEditBudgetSheet(BuildContext context) {
    return showModalBottomSheetApp(
      dismissOnTap: true,
      context: context,
      statusBarHeight: Get.height * .55,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15),
              Center(
                child: Container(
                  width: 70,
                  height: 5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(3),
                    ),
                    color: Theme.of(context).hintColor.withOpacity(.12),
                  ),
                ),
              ),
              Spacer(),
              Text(
                "Please enter the amount",
                style: kLabelStyleBold.copyWith(
                    fontSize: 18, color: Theme.of(context).hintColor),
              ),
              Spacer(),
              BudgetInput(),
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
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
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
        );
      },
    );
  }
}
