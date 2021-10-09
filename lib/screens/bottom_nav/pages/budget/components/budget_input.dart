part of budget_entry;

class BudgetInput extends GetView<BudgetController> {
  const BudgetInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String currancySymbol =
        PreferenceUtils.getString(currancy_symbol, defValue: '\u20B9');

    return CustomInput(
      controller: controller.amountController,
      hintText: amount.tr,
      validator: (value) => null,
      textInputType: TextInputType.number,
      isPrefix: true,
      prefixWidget: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            currancySymbol,
            style: kLabelStyle.copyWith(
                color: Theme.of(context).colorScheme.secondary, fontSize: 18),
          ),
        ],
      ),
      onchanged: (value) => value.isEmpty ? 0.0 : _renderMessage(value),
    );
  }

  _renderMessage(String val) {
    int value = double.parse(val).toInt();

    if (value > 3000) {
      print("3000");
      controller.message.value = controller.getMessage("Standard");
    }
    if (value > 5000) {
      print("5000");
      controller.message.value = controller.getMessage("Hyper");
    }
  }
}
