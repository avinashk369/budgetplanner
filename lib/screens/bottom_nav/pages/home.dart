import 'package:budgetplanner/controllers/test_controller.dart';
import 'package:budgetplanner/controllers/transaction_controller.dart';
import 'package:budgetplanner/models/BaseModel.dart';
import 'package:budgetplanner/models/budget_category_model.dart';
import 'package:budgetplanner/models/user_model.dart';
import 'package:budgetplanner/resources/firestore/userRepositoryImpl.dart';
import 'package:budgetplanner/screens/bottom_nav/pages/budget/budget_card.dart';
import 'package:budgetplanner/screens/bottom_nav/pages/transaction/recent_transaction.dart';
import 'package:budgetplanner/utils/styles.dart';
import 'package:budgetplanner/widgets/loading_ui.dart';
import 'package:budgetplanner/widgets/snack_bar.dart';
import 'package:budgetplanner/widgets/theme_constants.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:budgetplanner/utils/app_constants.dart';
import 'package:budgetplanner/widgets/config.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import 'budget/budget_list.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserRepositoryImpl userRepositoryImpl = UserRepositoryImpl();
  final controller2 = TransactionEntryController.to;
  TestController controller = Get.find<TestController>();
  TestController controller1 = Get.find<TestController>(tag: "buttonEvent");
  UserModel? userModel;

  late ScrollController _controller;
  bool silverCollapsed = false;
  String myTitle = "";

  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  void initState() {
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
    userModel = await controller.getUserDetail();
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
              expandedHeight: MediaQuery.of(context).size.height * .40,
              floating: false,
              pinned: true,
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(myTitle,
                      style:
                          kLabelStyle.apply(color: kWhite, fontSizeDelta: 6)),
                  background: Stack(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          width: Get.width,
                          height: Get.height,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      DateFormat('LLLL')
                                              .format(DateTime.now()) +
                                          " " +
                                          DateFormat('y')
                                              .format(DateTime.now())
                                              .toString()
                                              .substring(2),
                                      style: kTitleStyle,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text("Balance"),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text("5500"),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      child: Row(
                                        children: [
                                          Column(
                                            children: [
                                              Text("Income"),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text("5500"),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            width: 1,
                                            height: 40,
                                            color: whiteColor,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            children: [
                                              Text("Expense"),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text("5500"),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SleekCircularSlider(
                                key: Key("fasting_progress"),
                                innerWidget: (percentage) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: '100',
                                              style: kTitleStyle,
                                            ),
                                            TextSpan(
                                                text: '%',
                                                style: kTitleStyleSmall),
                                          ],
                                        ),
                                      )
                                    ],
                                  );
                                },
                                appearance: CircularSliderAppearance(
                                    size: Get.height * .20,
                                    startAngle: 280,
                                    angleRange: 350,
                                    customColors: CustomSliderColors(
                                      dotColor: kWhite,
                                      progressBarColor: Colors.green,
                                      trackColor: kGrey,
                                    ),
                                    customWidths: CustomSliderWidths(
                                      progressBarWidth: Get.height * .01,
                                    )),
                                min: 0,
                                max: 80,
                                initialValue: 50,
                                onChangeStart: (value) {},
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ];
        },
        body: CustomScrollView(
          slivers: [
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
                      child: BudgetList(),
                    ),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 10,
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    child: RecentTransaction(),
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
