import 'package:budgetplanner/controllers/dashboard_controller.dart';
import 'package:budgetplanner/controllers/transaction_controller.dart';
import 'package:budgetplanner/utils/PreferenceUtils.dart';
import 'package:budgetplanner/utils/app_constants.dart';
import 'package:budgetplanner/utils/controller_constants.dart';
import 'package:budgetplanner/utils/string_constants.dart';
import 'package:budgetplanner/widgets/custom_dialog.dart';
import 'package:budgetplanner/widgets/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:budgetplanner/utils/route_constants.dart';
import 'package:get/get.dart';
import 'bottom_nav/TabNavigationItem.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final controller = DashboardController.tagged(dashboardController);
  final transactionController = TransactionEntryController.to;
  //int _currentIndex = 0;
  String? userId;
  @override
  void initState() {
    transactionController.onInit();
    userId = PreferenceUtils.getString(user_id);
    //print("${FirebaseAuth.instance.currentUser!.uid} user id in dashboard");
    //_currentIndex = controller.currentIndex.value;
    // TODO: implement initState
    super.initState();
  }

  //On Home Page, for account icon pressed
  Future<void> checkCredsAndNavigate(int index) async {
    bool loggedIn = (userId != '')
        ? true
        : false; // this might be a function that gets status of user login, you can fetch from prefs, state, etc.
    if (!loggedIn && (index >= 0)) {
      Navigator.of(context).popAndPushNamed(loginRoute);
    } else {
      setState(() => controller.currentIndex.value = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final value = await showDialog<bool>(
            context: context,
            builder: (context) {
              return CustomDialog.customExitDialog(
                message: lbl_exit_message.tr,
                noButtonLabel: lbl_no.tr,
                yesButtonLabel: lbl_yes.tr,
                yes: () => Navigator.of(context).pop(true),
                no: () => Navigator.of(context).pop(false),
              );
            });

        return value == true;
      },
      child: Scaffold(
        body: Obx(() {
          return IndexedStack(
            index: controller.currentIndex.value,
            children: [
              TabNavigationItem.items[0].page,
              TabNavigationItem.items[1].page,
              TabNavigationItem.items[2].page,
              TabNavigationItem.items[3].page
            ],
          );
          //return TabNavigationItem.items[controller.currentIndex.value].page;
        }),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            boxShadow: [
              BoxShadow(
                  color: Theme.of(context).hintColor.withOpacity(0.3),
                  spreadRadius: 0,
                  blurRadius: 5),
            ],
          ),
          child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
              ),
              child: Obx(
                () => NavigationBarTheme(
                  data: const NavigationBarThemeData(
                    indicatorColor: Colors.deepPurple,
                  ),
                  child: NavigationBar(
                    backgroundColor: Colors.white,
                    height: 60,
                    selectedIndex: controller.currentIndex.value,
                    labelBehavior:
                        NavigationDestinationLabelBehavior.alwaysHide,
                    onDestinationSelected: (int index) {
                      checkCredsAndNavigate(index);
                    },
                    destinations: [
                      for (final tabItem in TabNavigationItem.items)
                        NavigationDestination(
                          icon: tabItem.icon,
                          label: tabItem.title,
                          selectedIcon: tabItem.selectedIcon,
                        ),
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
