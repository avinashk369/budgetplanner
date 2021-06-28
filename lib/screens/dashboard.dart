import 'package:budgetplanner/utils/PreferenceUtils.dart';
import 'package:budgetplanner/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:budgetplanner/utils/route_constants.dart';
import 'package:budgetplanner/widgets/theme_constants.dart';

import 'bottom_nav/TabNavigationItem.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 0;
  String? userId;
  @override
  void initState() {
    userId = PreferenceUtils.getString(user_id);
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
      setState(() => _currentIndex = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabNavigationItem.items[_currentIndex].page,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).hintColor.withOpacity(0.5),
                spreadRadius: 0,
                blurRadius: 10),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (int index) {
              checkCredsAndNavigate(index);
            },
            items: <BottomNavigationBarItem>[
              for (final tabItem in TabNavigationItem.items)
                BottomNavigationBarItem(
                  icon: tabItem.icon,
                  label: tabItem.title,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
