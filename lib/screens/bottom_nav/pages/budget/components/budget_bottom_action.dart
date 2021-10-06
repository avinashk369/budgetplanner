import 'package:budgetplanner/controllers/budget_controller.dart';
import 'package:budgetplanner/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BudgetBottom extends GetView<BudgetController> {
  const BudgetBottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 15),
      child: SizedBox(
        height: Get.height * .6 - 95,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
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
                child: Obx(
                  () => Text(
                    controller.budgetDetail.value.amount.toString() == 'null'
                        ? controller.currencySymbol + '0.0'
                        : controller.slidervalue.value > 1
                            ? controller.currencySymbol +
                                controller.slidervalue.value
                                    .roundToDouble()
                                    .toString()
                            : controller.currencySymbol +
                                controller.budgetDetail.value.amount.toString(),
                    style: kLabelStyleBold.copyWith(fontSize: 30),
                  ),
                ),
              ),
              Spacer(),
              Obx(
                () => Slider(
                  value: controller.slidervalue.value,
                  onChanged: (value) {
                    if (value > 3) {
                      controller.message.value =
                          controller.getMessage('Normal');
                    }
                    if (value > 5) {
                      controller.message.value =
                          controller.getMessage('Standard');
                    }
                    if (value > 7) {
                      controller.message.value = controller.getMessage('Hyper');
                    }

                    controller.slidervalue.value = value;
                  },
                  min: 10,
                  max: 1000,
                  divisions: 10,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Obx(
                  () => controller.message.isNotEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.message.keys.first,
                              style: kLabelStyleBold.copyWith(fontSize: 20),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              controller.message.values.first,
                              style: kLabelStyle,
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
                  child: Text(
                    "Submit",
                    style: kLabelStyleBold.copyWith(
                        color: Theme.of(context).primaryColor, fontSize: 18),
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
