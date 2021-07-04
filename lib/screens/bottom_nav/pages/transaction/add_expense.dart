import 'package:budgetplanner/ad/ad_helper.dart';
import 'package:budgetplanner/controllers/ad_controller.dart';
import 'package:budgetplanner/controllers/expense_controller.dart';
import 'package:budgetplanner/screens/bottom_nav/pages/transaction/expense_form.dart';
import 'package:budgetplanner/utils/controller_constants.dart';
import 'package:budgetplanner/utils/string_constants.dart';
import 'package:budgetplanner/widgets/quote_container.dart';
import 'package:budgetplanner/widgets/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AddExpense extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = ExpenseController.tagged(expenseController);
    final adCont = AdController.tagged(adController);

    final String quote = "\"Keep notes of all of your expenses\"";
    final String author = "Mr. Budget";
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kSpaceS, vertical: kSpaceM),
      child: CustomScrollView(
        //controller: ScrollController(),
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverToBoxAdapter(
            //child: QuoteContainer(quote, author),
            child: Obx(() => (adCont.isBannerAdReady.value)
                ? Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: adCont.bannerAd.size.width.toDouble(),
                      height: adCont.bannerAd.size.height.toDouble(),
                      child: AdWidget(ad: adCont.bannerAd),
                    ),
                  )
                : Container()),
          ),
          SliverToBoxAdapter(
            child:SizedBox(
              height:10,
            )
          ),
          SliverToBoxAdapter(
            child: Form(
              key: controller.expenseKey,
              child: Column(
                children: [
                  ExpenseForm(controller: controller),
                  SizedBox(
                    height: 20,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      controller.submitIncomeRecord(context);
                    },
                    child: Text(addExpense.tr),
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
