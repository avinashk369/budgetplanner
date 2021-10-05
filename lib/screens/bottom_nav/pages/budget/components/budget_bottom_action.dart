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
            color: Colors.grey[50],
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Obx(
                () => controller.budgetDetail.value.catName != null
                    ? Text(
                        controller.budgetDetail.value.catName!,
                        style: kLabelStyleBold,
                      )
                    : Text(
                        controller.budgetDetail.value.toJson().toString(),
                        style: kLabelStyleBold,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
