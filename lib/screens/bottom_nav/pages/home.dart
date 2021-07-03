import 'package:budgetplanner/controllers/test_controller.dart';
import 'package:budgetplanner/controllers/transaction_controller.dart';
import 'package:budgetplanner/models/BaseModel.dart';
import 'package:budgetplanner/models/user_model.dart';
import 'package:budgetplanner/resources/firestore/userRepositoryImpl.dart';
import 'package:budgetplanner/screens/bottom_nav/pages/transaction/recent_transaction.dart';
import 'package:budgetplanner/utils/PreferenceUtils.dart';
import 'package:budgetplanner/utils/string_constants.dart';
import 'package:budgetplanner/utils/styles.dart';
import 'package:budgetplanner/widgets/header_row.dart';
import 'package:budgetplanner/widgets/loading_ui.dart';
import 'package:budgetplanner/widgets/no_data.dart';
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
  UserModel? userModel;
  late String userId;
  late ScrollController _controller;
  bool silverCollapsed = false;
  String myTitle = "";

  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  void initState() {
    userId = PreferenceUtils.getString(user_id);

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
    super.initState();
  }

  void getUserData() async {
    userModel = await controller.getUserDetail(userId);
    print("User info ${userModel!.email}");
  }

  Future<UserModel> getUser() async {
    BaseModel<UserModel> user =
        await userRepositoryImpl.getUser("wyly5t8m8yTisWgEUA6BDRbd7xp2");
    print(user.data!.email);
    return user.data!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: _controller,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: MediaQuery.of(context).size.height * .35,
              floating: false,
              pinned: true,
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(myTitle,
                      style: kLabelStyle.apply(
                          color: Theme.of(context).hintColor,
                          fontSizeDelta: 6)),
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
                height: 10,
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * .30,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.transparent, width: 0),
                      ),
                      child: Obx(() {
                        if (transactionController.budgetList.isEmpty) {
                          return Center(
                              child: NoData(
                            message: "No budget allocated",
                            imageUrl:
                                "https://image.freepik.com/free-vector/estate-tax-composition_98292-7428.jpg",
                            index: 3,
                          ));
                        } else {
                          return controller.isLoading()
                              ? Center(child: LoadingUI())
                              : BudgetList(
                                  budgetModel: transactionController.budgetList,
                                );
                        }
                      }),
                    ),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
                child: Container(
              padding: EdgeInsets.only(top: 10, bottom: 5, left: 10),
              child: Text(recent_transaction.tr),
            )),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    child: Obx(() {
                      if (transactionController.recentTransactionList.isEmpty) {
                        return Center(
                            child: NoData(
                          message: "No transaction available",
                          imageUrl: "",
                          index: 2,
                        ));
                      } else {
                        return controller.isLoading()
                            ? Center(child: LoadingUI())
                            : RecentTransaction(
                                transactionModelList:
                                    transactionController.recentTransactionList,
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
    );
  }
}
