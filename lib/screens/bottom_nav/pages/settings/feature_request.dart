import 'package:budgetplanner/ad/banner_ad.dart';
import 'package:budgetplanner/controllers/ad_controller.dart';
import 'package:budgetplanner/controllers/settings_controller.dart';
import 'package:budgetplanner/screens/bottom_nav/pages/settings/request_form.dart';
import 'package:budgetplanner/screens/bottom_nav/pages/transaction/income_form.dart';
import 'package:budgetplanner/utils/app_constants.dart';
import 'package:budgetplanner/utils/controller_constants.dart';
import 'package:budgetplanner/utils/string_constants.dart';
import 'package:budgetplanner/utils/styles.dart';
import 'package:budgetplanner/widgets/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeatureRequestScreen extends StatelessWidget {
  const FeatureRequestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = SettingsController.tagged(features);
    final adCont = AdController.tagged(adController);

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
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 8),
                      height: Get.height * .15,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Request for new",
                            style: kLabelStyle.apply(
                                color: Theme.of(context).hintColor),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Feature",
                            style: Theme.of(context).textTheme.headline1,
                          )
                        ],
                      ),
                    ),
                    //BudgetCard()
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: Form(
                  key: controller.featureKey,
                  child: Column(
                    children: [
                      RequestForm(controller: controller),
                      SizedBox(
                        height: 20,
                      ),
                      OutlinedButton(
                        onPressed: () {
                          controller.submitRequest(context);
                        },
                        child: Text(submit),
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
