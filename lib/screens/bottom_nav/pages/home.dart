import 'package:budgetplanner/controllers/ad_controller.dart';
import 'package:budgetplanner/controllers/dashboard_controller.dart';
import 'package:budgetplanner/controllers/test_controller.dart';
import 'package:budgetplanner/controllers/transaction_controller.dart';
import 'package:budgetplanner/models/user_model.dart';
import 'package:budgetplanner/resources/firestore/userRepositoryImpl.dart';
import 'package:budgetplanner/screens/bottom_nav/pages/promotional_screen.dart';
import 'package:budgetplanner/screens/bottom_nav/pages/transaction/recent_transaction.dart';
import 'package:budgetplanner/utils/PreferenceUtils.dart';
import 'package:budgetplanner/utils/controller_constants.dart';
import 'package:budgetplanner/utils/route_constants.dart';
import 'package:budgetplanner/utils/string_constants.dart';
import 'package:budgetplanner/utils/styles.dart';
import 'package:budgetplanner/widgets/budget_shimmer.dart';
import 'package:budgetplanner/widgets/custom_theme.dart';
import 'package:budgetplanner/widgets/header_row.dart';
import 'package:budgetplanner/widgets/no_data.dart';
import 'package:budgetplanner/widgets/theme_constants.dart';
import 'package:budgetplanner/widgets/trx_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:budgetplanner/utils/app_constants.dart';
import 'package:get/get.dart';

import 'budget/budget_list.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserRepositoryImpl userRepositoryImpl = UserRepositoryImpl();
  final transactionController = TransactionEntryController.to;
  TestController controller = Get.find<TestController>();
  TestController controller1 = Get.find<TestController>(tag: "buttonEvent");
  final adCont = AdController.tagged(adController);
  UserModel? userModel;
  late String userId;
  late ScrollController _controller;
  bool silverCollapsed = false;
  String myTitle = "";

  final PageController _pageController = PageController(initialPage: 0);
  final dashController = DashboardController.tagged(dashboardController);
  int _currentPage = 0;

  @override
  void initState() {
    userId = PreferenceUtils.getString(user_id);
    print("$userId user id in home ${PreferenceUtils.getString(user_id)}");
    // TODO: implement initState
    _controller = ScrollController();

    _controller.addListener(() {
      if (_controller.offset > MediaQuery.of(context).size.height * .25 &&
          !_controller.position.outOfRange) {
        if (!silverCollapsed) {
          // do what ever you want when silver is collapsing !

          myTitle = appname;
          silverCollapsed = true;
          setState(() {});
        }
      }
      if (_controller.offset <= MediaQuery.of(context).size.height * .25 &&
          !_controller.position.outOfRange) {
        if (silverCollapsed) {
          // do what ever you want when silver is expanding !

          myTitle = "";
          silverCollapsed = false;
          setState(() {});
        }
      }
    });
    getUserData();
    getPromotions();
    //showRewardAd();
    super.initState();
  }

  void showRewardAd() {
    //to display rewarded ad
    if (adCont.isRewardedAdReady.value) {
      adCont.rewardedAd?.show(
        onUserEarnedReward: (ad, reward) {},
      );
    }
  }

  void getUserData() async {
    userModel = await controller.getUserDetail(userId);
    //print("User info ${userModel?.email}");
  }

  Future getPromotions() async {
    transactionController.promotionsList
        .bindStream(transactionController.getAlPromotions()!);
  }

  // Future<UserModel> getUser() async {
  //   BaseModel<UserModel> user =
  //       await userRepositoryImpl.getUser("wyly5t8m8yTisWgEUA6BDRbd7xp2");
  //   print(user.data!.email);
  //   return user.data!;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
        heroTag: "transaction",
        //backgroundColor: Theme.of(context).hintColor,
        onPressed: () {
          Navigator.of(context).pushNamed(addTransactionRoute);
        },
        backgroundColor: redColor,

        icon: Icon(
          Icons.edit,
          color: Theme.of(context).primaryColor,
          size: 18,
        ),
        label: Padding(
          padding: const EdgeInsets.only(bottom: 3),
          child: Text(
            transactionTab.tr,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w700,
                color: Theme.of(context).primaryColor,
                letterSpacing: 1.2),
          ),
        ),
      ),
      body: SafeArea(
        child: NestedScrollView(
          controller: _controller,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: MediaQuery.of(context).size.height * .28,
                floating: false,
                pinned: true,
                elevation: 0,
                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text(
                      myTitle,
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                color: shade,
                                fontWeight: FontWeight.w700,
                              ),
                    ),
                    background: Obx(() => (!transactionController.isLoading())
                        ? HeaderRow(
                            income: transactionController.totalIncome.value,
                            expense: transactionController.totalExpense.value,
                          )
                        : Container())),
              ),
            ];
          },
          body: CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 0,
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PromotionalScreen(),
                ),
              ),
              SliverToBoxAdapter(
                child: Obx(
                  () => transactionController.budgetList.isNotEmpty
                      ? Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                padding: EdgeInsets.only(
                                    top: 10, bottom: 5, left: 10),
                                child: Text(
                                  monthly_budget.tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          color: Theme.of(context)
                                              .hintColor
                                              .withOpacity(.8),
                                          fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: ChoiceChip(
                                label: RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                    text: "View all ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: Theme.of(context)
                                              .hintColor
                                              .withOpacity(.8),
                                          fontWeight: FontWeight.w700,
                                        ),
                                  ),
                                ])),
                                onSelected: (value) {
                                  dashController.setindex(2);
                                },
                                selected: true,
                                selectedColor:
                                    CustomTheme().currentTheme == ThemeMode.dark
                                        ? kDarkGrey
                                        : Colors.grey[100],
                              ),
                            ),
                          ],
                        )
                      : SizedBox(),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Obx(
                        () => Container(
                          width: MediaQuery.of(context).size.width,
                          height: (transactionController.budgetList.isNotEmpty)
                              ? MediaQuery.of(context).size.height * .30
                              : MediaQuery.of(context).size.height * .45,
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.transparent, width: 0),
                          ),
                          child: Obx(() {
                            if (transactionController.budgetList.isEmpty) {
                              return NoData(
                                title: lbl_no_budget.tr,
                                message: desc_no_budget.tr,
                                imageUrl: 'assets/bl4.png',
                                index: 2,
                                goTo: () {
                                  dashController.setindex(2);
                                },
                              );
                            } else {
                              return controller.isLoading()
                                  ? BudgetShimmer()
                                  : BudgetList(
                                      budgetModel:
                                          transactionController.budgetList,
                                    );
                            }
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: Obx(
                  () => transactionController.recentTransactionList.isNotEmpty
                      ? Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                padding: EdgeInsets.only(
                                    top: 10, bottom: 5, left: 10),
                                child: Text(
                                  recent_transaction.tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        color: Theme.of(context)
                                            .hintColor
                                            .withOpacity(.8),
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: ChoiceChip(
                                label: RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                    text: "View all ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: Theme.of(context)
                                              .hintColor
                                              .withOpacity(.8),
                                          fontWeight: FontWeight.w700,
                                        ),
                                  ),
                                ])),
                                onSelected: (value) {
                                  dashController.setindex(1);
                                },
                                selected: true,
                                selectedColor:
                                    CustomTheme().currentTheme == ThemeMode.dark
                                        ? kDarkGrey
                                        : Colors.grey[100],
                              ),
                            ),
                          ],
                        )
                      : SizedBox(),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Container(
                      child: Obx(() {
                        if (transactionController
                            .recentTransactionList.isEmpty) {
                          return NoData(
                            title: lbl_no_transaction.tr,
                            message: desc_no_transaction.tr,
                            imageUrl: 'assets/grp.png',
                            index: 2,
                            goTo: () {
                              Navigator.of(context)
                                  .pushNamed(addTransactionRoute);
                            },
                          );
                        } else {
                          return controller.isLoading()
                              ? TrxShimmer()
                              : RecentTransaction(
                                  transactionModelList: transactionController
                                      .recentTransactionList,
                                );
                        }
                      }),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
