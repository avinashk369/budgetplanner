import 'package:budgetplanner/ad/banner_ad.dart';
import 'package:budgetplanner/controllers/ad_controller.dart';
import 'package:budgetplanner/controllers/budget_controller.dart';
import 'package:budgetplanner/models/budget_category_model.dart';
import 'package:budgetplanner/models/budget_model.dart';
import 'package:budgetplanner/utils/controller_constants.dart';
import 'package:budgetplanner/utils/string_constants.dart';
import 'package:budgetplanner/utils/styles.dart';
import 'package:budgetplanner/widgets/custom_dialog.dart';
import 'package:budgetplanner/widgets/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'budget_form.dart';

class UpdateBudget extends StatelessWidget {
  final BudgetModel budgetModel;
  const UpdateBudget({Key? key, required this.budgetModel}) : super(key: key);
  iniBudget(BudgetController budgetC) {
    BudgetCategoryModel budgetCategoryModel = BudgetCategoryModel();
    budgetCategoryModel.name = budgetModel.catName;

    budgetC.setBudgetModel(budgetCategoryModel);

    budgetC.notesController.text = budgetModel.notes!;
    budgetC.amountController.text = budgetModel.amount.toString();
  }

  @override
  Widget build(BuildContext context) {
    final controller = BudgetController.tagged(updateBudgetController);
    final adCont = AdController.tagged(adController);

    iniBudget(controller);
    return Scaffold(
      appBar: AppBar(elevation: 0),
      body: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: kSpaceS, vertical: kSpaceM),
          child: CustomScrollView(
            //controller: ScrollController(),
            physics: BouncingScrollPhysics(),
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 8),
                      height: Get.height * .15,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            update_plan_month.tr,
                            style: kLabelStyle.apply(
                                color: Theme.of(context).hintColor),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            budgetTab.tr,
                            style: Theme.of(context).textTheme.headline1,
                          )
                        ],
                      ),
                    ),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        minimumSize: Size(50, 50),
                        primary: whiteColor,
                        side: BorderSide(
                          color: heenColor,
                          width: 1,
                        ),
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) {
                            return CustomDialog.deleteDiaolg(
                                yes: () async {
                                  Navigator.of(context).pop(true);
                                  await controller.deleteBudget(
                                      context, budgetModel.id!);
                                  print(budgetModel.catName);
                                },
                                no: () => Navigator.of(context).pop(false),
                                yesButtonLabel: delete.tr,
                                noButtonLabel: cancel.tr,
                                message: lbl_delete_message.tr);
                          },
                        );
                      },
                      child: Icon(
                        Icons.delete,
                        color: Theme.of(context).hintColor,
                      ),
                    )
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 10,
                ),
              ),
              SliverToBoxAdapter(
                child: Form(
                  key: controller.updateBudgetKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      BudgetForm(controller: controller),
                      SizedBox(
                        height: 20,
                      ),
                      OutlinedButton(
                        onPressed: () {
                          controller.updateBudget(context, budgetModel);
                        },
                        child: Text(updateBudget.tr),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BannerAdView(),
    );
  }
}
