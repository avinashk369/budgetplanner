import 'package:budgetplanner/screens/bottom_nav/pages/transaction/transaction.dart';
import 'package:budgetplanner/utils/string_constants.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

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
          title: homeTab,
        ),
        TabNavigationItem(
          page: TransactionHistory(),
          icon: Icon(Icons.receipt_long),
          title: transactionTab,
        ),
        TabNavigationItem(
          page: Transaction(),
          icon: Icon(Icons.add_box_rounded),
          title: addTab,
        ),
        TabNavigationItem(
          page: HomePage(),
          icon: Icon(Icons.show_chart),
          title: statsTab,
        ),
        TabNavigationItem(
          page: HomePage(),
          icon: Icon(Icons.settings),
          title: settingsTab,
        ),
      ];
}
