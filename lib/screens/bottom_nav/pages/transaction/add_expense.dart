import 'package:budgetplanner/controllers/expense_controller.dart';
import 'package:budgetplanner/resources/firestore/dataRepositoryImpl.dart';
import 'package:budgetplanner/utils/category_constants.dart';
import 'package:budgetplanner/utils/controller_constants.dart';
import 'package:budgetplanner/utils/string_constants.dart';
import 'package:budgetplanner/utils/styles.dart';
import 'package:budgetplanner/widgets/category_choser.dart';
import 'package:budgetplanner/widgets/custom_input.dart';
import 'package:budgetplanner/widgets/dashed_rect.dart';
import 'package:budgetplanner/widgets/theme_constants.dart';
import 'package:budgetplanner/widgets/transaction_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddExpense extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = ExpenseController.tagged(expenseController);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kSpaceS, vertical: kSpaceM),
      child: CustomScrollView(
        //controller: ScrollController(),
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(left: 8, top: 20),
              height: Get.height * .15,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Add your daily",
                    style:
                        kLabelStyle.apply(color: Theme.of(context).hintColor),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Expense",
                    style: kTitleStyle,
                  )
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Form(
              key: controller.expenseKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
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
                          controller.budgetCatModel.value.name ??
                              select_expense_category)),
                      rightRowData: Obx(
                        () => controller.budgetCatModel.value.name != null
                            ? Container(
                                height: 35,
                                width: 35,
                                margin: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: DataRepositoryImpl()
                                      .iconUrl(controller
                                          .budgetCatModel.value.name!)!
                                      .colorName,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                child: Icon(
                                  DataRepositoryImpl()
                                      .iconUrl(controller
                                          .budgetCatModel.value.name!)!
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
                  InkWell(
                    onTap: () {
                      controller.expenseSourceModal(
                        context,
                        controller.expenseSourceList,
                        (value) {
                          Navigator.of(context).pop();
                          controller.expenseSourceModel(value);
                          print("Call back function ${value.name}");
                        },
                      );
                    },
                    child: CategoryChooser(
                      leftRowData: Text(select_expense_source),
                      rightRowData: Obx(
                        () => Text(controller.expenseSourceModel.value.name ??
                            def_source),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 56,
                    width: Get.width,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).hintColor.withOpacity(.12),
                            width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Expense type',
                        ),
                        Row(
                          children: [
                            Obx(
                              () => Checkbox(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3.0)),
                                checkColor: whiteColor,
                                activeColor: redColor,
                                value: controller.isWant(),
                                onChanged: (bool? value) {
                                  print(value);
                                  controller.isWant(value);
                                },
                              ),
                            ),
                            Text(
                              'Want/Need',
                            ),
                          ],
                        )
                      ],
                    ),
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
                      leftRowData: Text(recurrance),
                      rightRowData: Obx(
                        () => Text(controller.recurranceModel.value.name ??
                            def_recurrance),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      controller.submitIncomeRecord(context);
                    },
                    child: Text(addExpense),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
