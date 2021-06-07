import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import 'pages/home.dart';

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
          title: "Feed",
        ),
        // TabNavigationItem(
        //   page: AllQuiz(),
        //   icon: Icon(EvaIcons.clockOutline),
        //   title: "Quiz",
        // ),

        TabNavigationItem(
          page: HomePage(),
          icon: Icon(Icons.timer),
          title: "Timer",
        ),
        TabNavigationItem(
          page: HomePage(),
          icon: Icon(Icons.badge),
          title: "Challenges",
        ),
        TabNavigationItem(
          page: HomePage(),
          icon: Icon(Icons.book_outlined),
          title: "Learn",
        ),
        TabNavigationItem(
          page: HomePage(),
          icon: Icon(EvaIcons.person),
          title: "Profile",
        ),
      ];
}
