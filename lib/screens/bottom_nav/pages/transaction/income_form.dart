import 'package:budgetplanner/controllers/income_controller.dart';
import 'package:budgetplanner/resources/firestore/dataRepositoryImpl.dart';
import 'package:budgetplanner/utils/PreferenceUtils.dart';
import 'package:budgetplanner/utils/app_constants.dart';
import 'package:budgetplanner/utils/category_constants.dart';
import 'package:budgetplanner/utils/string_constants.dart';
import 'package:budgetplanner/utils/styles.dart';
import 'package:budgetplanner/widgets/category_choser.dart';
import 'package:budgetplanner/widgets/custom_input.dart';
import 'package:budgetplanner/widgets/dashed_rect.dart';
import 'package:budgetplanner/widgets/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IncomeForm extends StatelessWidget {
  final IncomeController controller;
  const IncomeForm({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String currancySymbol =
        PreferenceUtils.getString(currancy_symbol, defValue: '\u20B9');
    return Column(
      children: [
        InkWell(
          onTap: () {
            controller.modalBottomSheetMenu(
              context,
              controller.catList,
              (value) {
                Navigator.of(context).pop();
                print("Call back function ${value.name}");
              },
            );
          },
          child: CategoryChooser(
            leftRowData: Obx(() => Text(
                controller.incomeModel.value.name ?? select_income_source.tr)),
            rightRowData: Obx(
              () => controller.incomeModel.value.name != null
                  ? Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                        color: DataRepositoryImpl()
                            .iconUrl(controller.incomeModel.value.name!)!
                            .colorName,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Icon(
                        DataRepositoryImpl()
                            .iconUrl(controller.incomeModel.value.name!)!
                            .iconName,
                        color: whiteColor,
                      ),
                    )
                  : Container(
                      height: 35,
                      width: 35,
                      child: DashedRect(
                        color: Theme.of(context).hintColor,
                        strokeWidth: 1.0,
                      ),
                    ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        CustomInput(
          controller: controller.amountController,
          hintText: amount.tr,
          validator: (value) => controller.validateAmount(value!),
          textInputType: TextInputType.number,
          isPrefix: true,
          prefixWidget: SizedBox(
            child: Center(
              widthFactor: 0.0,
              child: Text(
                currancySymbol,
                style: kLabelStyle.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 20),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        CustomInput(
          controller: controller.notesController,
          hintText: notes.tr,
          validator: (value) => controller.validatePassword(value!),
        ),
        SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () {
            controller.recurranceModal(
              context,
              controller.recurranceList,
              (value) {
                Navigator.of(context).pop();
                controller.recurranceModel(value);
                (controller.recurranceModel.value.name != never)
                    ? controller.isRecurring(true)
                    : controller.isRecurring(false);
                print("Call back function ${value.name}");
              },
            );
          },
          child: CategoryChooser(
            leftRowData: Text(recurrance.tr),
            rightRowData: Obx(
              () =>
                  Text(controller.recurranceModel.value.name ?? def_recurrance),
            ),
          ),
        ),
      ],
    );
  }
}
