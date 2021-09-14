import 'package:budgetplanner/screens/bottom_nav/pages/budget/add_budget.dart';
import 'package:budgetplanner/screens/bottom_nav/pages/settings/settings.dart';
import 'package:budgetplanner/screens/bottom_nav/pages/transaction/transaction.dart';
import 'package:budgetplanner/utils/string_constants.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'pages/home.dart';
import 'pages/transaction/transaction_history.dart';

class TabNavigationItem {
  final Widget page;
  final String title;
  final Icon icon;

  TabNavigationItem({
    required this.page,
    required this.title,
    required this.icon,
  });

  static List<TabNavigationItem> get items => [
        TabNavigationItem(
          page: HomePage(),
          icon: Icon(EvaIcons.homeOutline),
          title: homeTab.tr,
        ),
        TabNavigationItem(
          page: TransactionHistory(),
          icon: Icon(Icons.timeline),
          title: historyTab.tr,
        ),
        // TabNavigationItem(
        //   page: Transaction(),
        //   icon: Icon(Icons.add_box_rounded),
        //   title: addTab.tr,
        // ),
        TabNavigationItem(
          page: AddBudget(),
          icon: Icon(Icons.savings),
          title: budgetTab.tr,
        ),
        TabNavigationItem(
          page: Settings(),
          icon: Icon(Icons.settings),
          title: settingsTab.tr,
        ),
      ];
}
