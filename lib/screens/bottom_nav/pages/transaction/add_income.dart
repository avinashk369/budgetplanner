import 'package:budgetplanner/controllers/income_controller.dart';
import 'package:budgetplanner/screens/bottom_nav/pages/transaction/income_form.dart';
import 'package:budgetplanner/utils/controller_constants.dart';
import 'package:budgetplanner/utils/string_constants.dart';
import 'package:budgetplanner/widgets/quote_container.dart';
import 'package:budgetplanner/widgets/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddIncome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = IncomeController.tagged(incomeController);
    final String quote =
        "\"I will tell you how to become rich. Close the doors. Be fearful when others are greedy. Be greedy when others are fearful.\"";
    final String author = "Warren Buffett";
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kSpaceS, vertical: kSpaceM),
      child: CustomScrollView(
        //controller: ScrollController(),
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: QuoteContainer(quote, author),
          ),
          SliverToBoxAdapter(
            child: Form(
              key: controller.incomeKey,
              child: Column(
                children: [
                  IncomeForm(controller: controller),
                  SizedBox(
                    height: 20,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      controller.submitIncomeRecord(context);
                    },
                    child: Text(addIncome.tr),
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
