import 'package:budgetplanner/screens/bottom_nav/pages/settings/settings.dart';
import 'package:budgetplanner/utils/string_constants.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'pages/budget/screens/budget_entry.dart';
import 'pages/home.dart';
import 'pages/transaction/transaction_history.dart';

class TabNavigationItem {
  final Widget page;
  final String title;
  final Icon icon;
  final Icon selectedIcon;

  TabNavigationItem({
    required this.page,
    required this.title,
    required this.icon,
    required this.selectedIcon,
  });

  static List<TabNavigationItem> get items => [
        TabNavigationItem(
          page: HomePage(),
          icon: Icon(EvaIcons.homeOutline),
          title: homeTab.tr,
          selectedIcon: Icon(
            EvaIcons.home,
            color: Colors.white,
          ),
        ),
        TabNavigationItem(
          page: TransactionHistory(),
          icon: Icon(Icons.timeline_outlined),
          selectedIcon: Icon(
            Icons.timeline,
            color: Colors.white,
          ),
          title: historyTab.tr,
        ),
        // TabNavigationItem(
        //   page: Transaction(),
        //   icon: Icon(Icons.add_box_rounded),
        //   title: addTab.tr,
        // ),
        TabNavigationItem(
          page: BudgetEntry(),
          icon: Icon(
            Icons.savings_outlined,
          ),
          selectedIcon: Icon(
            Icons.savings,
            color: Colors.white,
          ),
          title: budgetTab.tr,
        ),
        TabNavigationItem(
          page: Settings(),
          icon: Icon(Icons.settings_outlined),
          selectedIcon: Icon(
            Icons.settings,
            color: Colors.white,
          ),
          title: settingsTab.tr,
        ),
      ];
}
