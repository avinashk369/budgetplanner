import 'package:budgetplanner/controllers/budget_controller.dart';
import 'package:budgetplanner/resources/firestore/dataRepositoryImpl.dart';
import 'package:budgetplanner/utils/string_constants.dart';
import 'package:budgetplanner/widgets/category_choser.dart';
import 'package:budgetplanner/widgets/custom_input.dart';
import 'package:budgetplanner/widgets/dashed_rect.dart';
import 'package:budgetplanner/widgets/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BudgetForm extends StatelessWidget {
  final BudgetController controller;
  const BudgetForm({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            controller.modalBottomSheetMenu(
              context,
              controller.catList,
              (value) {
                Navigator.of(context).pop();
                print("Call back avi ${value.name}");
              },
            );
          },
          child: CategoryChooser(
            leftRowData: Obx(() => Text(controller.budgetCatModel.value.name ??
                select_budget_category)),
            rightRowData: Obx(
              () => controller.budgetCatModel.value.name != null
                  ? Container(
                      height: 35,
                      width: 35,
                      margin: EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(
                        color: DataRepositoryImpl()
                            .iconUrl(controller.budgetCatModel.value.name!)!
                            .colorName,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Icon(
                        DataRepositoryImpl()
                            .iconUrl(controller.budgetCatModel.value.name!)!
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
                        gap: 2.0,
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
          hintText: amount,
          validator: (value) => controller.validateAmount(value!),
          textInputType: TextInputType.number,
        ),
        SizedBox(
          height: 10,
        ),
        CustomInput(
          controller: controller.notesController,
          hintText: notes,
          validator: (value) => controller.validatePassword(value!),
        ),
        SizedBox(
          height: 10,
        ),
        CategoryChooser(
          leftRowData: Text(monthName),
          rightRowData: Text(DateFormat('LLLL').format(DateTime.now())),
        ),
      ],
    );
  }
}
