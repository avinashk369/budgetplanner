import 'package:budgetplanner/ad/banner_ad.dart';
import 'package:budgetplanner/controllers/ad_controller.dart';
import 'package:budgetplanner/screens/bottom_nav/pages/transaction/add_expense.dart';
import 'package:budgetplanner/screens/bottom_nav/pages/transaction/add_income.dart';
import 'package:budgetplanner/utils/controller_constants.dart';
import 'package:budgetplanner/utils/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class Transaction extends StatefulWidget {
  const Transaction({Key? key}) : super(key: key);

  @override
  _TransactionState createState() => _TransactionState();
}

class _TransactionState extends State<Transaction>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController _scrollViewController;
  final adCont = AdController.tagged(adController);
  List<String> name = [
    total_expense.tr,
    total_income.tr,
    //saving,
  ];
  @override
  void initState() {
    print("hey");
    super.initState();
    // if (adCont.isInterstitialAdReady.value) {
    //   adCont.interstitialAd?.show();
    // }
    //to display rewarded ad
    // if (adCont.isRewardedAdReady.value) {
    //   adCont.rewardedAd.show(
    //     onUserEarnedReward: (ad, reward) {
    //       print("${reward.amount} amount earned");
    //     },
    //   );
    // }
    _tabController = TabController(vsync: this, length: name.length);
    _scrollViewController = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();

    _tabController.dispose();
    _scrollViewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        physics: BouncingScrollPhysics(),
        controller: _scrollViewController,
        headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              centerTitle: true,
              title: Text(
                transactionEntry.tr,
              ),
              floating: true,
              pinned: true,
              snap: true,
              bottom: TabBar(
                tabs: <Widget>[
                  for (final tabItem in name)
                    Tab(
                      child: Text(tabItem),
                    ),
                ],
                controller: _tabController,
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            AddExpense(),
            AddIncome(),
            //AddSaving(),
          ],
        ),
      ),
      bottomNavigationBar: BannerAdView(),
    );
  }
}
