import 'package:budgetplanner/controllers/income_controller.dart';
import 'package:budgetplanner/controllers/login_controller.dart';
import 'package:budgetplanner/resources/firestore/dataRepositoryImpl.dart';
import 'package:budgetplanner/utils/controller_constants.dart';
import 'package:budgetplanner/utils/string_constants.dart';
import 'package:budgetplanner/widgets/category_choser.dart';
import 'package:budgetplanner/widgets/custom_input.dart';
import 'package:budgetplanner/widgets/dashed_rect.dart';
import 'package:budgetplanner/widgets/theme_constants.dart';
import 'package:budgetplanner/widgets/transaction_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddIncome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = IncomeController.tagged(incomeController);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kSpaceS, vertical: kSpaceM),
      child: CustomScrollView(
        //controller: ScrollController(),
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Form(
              key: controller.incomeKey,
              child: Column(
                children: [
                  TransactionHeader(
                    imageUrl:
                        "https://image.freepik.com/free-vector/stock-market-investing-online-monetization-remote-job-freelance-work_335657-3022.jpg",
                  ),
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
                          controller.incomeModel.value.name ??
                              select_income_source)),
                      rightRowData: Obx(
                        () => controller.incomeModel.value.name != null
                            ? Container(
                                height: 35,
                                width: 35,
                                margin: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: DataRepositoryImpl()
                                      .iconUrl(
                                          controller.incomeModel.value.name!)!
                                      .colorName,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                child: Icon(
                                  DataRepositoryImpl()
                                      .iconUrl(
                                          controller.incomeModel.value.name!)!
                                      .iconName,
                                  color: Theme.of(context).hintColor,
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
                      controller.recurranceModal(
                        context,
                        controller.recurranceList,
                        (value) {
                          Navigator.of(context).pop();
                          controller.recurranceModel(value);
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
                    child: Text("Submit"),
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
