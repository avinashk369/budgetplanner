import 'package:flutter/material.dart';
import 'package:budgetplanner/utils/route_constants.dart';
import 'package:budgetplanner/widgets/theme_constants.dart';

import 'bottom_nav/TabNavigationItem.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 1;
  int userId = 0;
  //On Home Page, for account icon pressed
  Future<void> checkCredsAndNavigate(int index) async {
    bool loggedIn = (userId > 0)
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
      // body: IndexedStack(
      //   index: _currentIndex,
      //   children: <Widget>[
      //     for (final tabItem in TabNavigationItem.items) tabItem.page,
      //   ],
      // ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
            // sets the background color of the `BottomNavigationBar`
            canvasColor: kWhite,
            // sets the active color of the `BottomNavigationBar` if `Brightness` is light
            primaryColor: maincolor,
            textTheme: Theme.of(context).textTheme.copyWith(
                caption: new TextStyle(
                    color:
                        kGrey))), // sets the inactive color of the `BottomNavigationBar`

        child: BottomNavigationBar(
          backgroundColor: kWhite,
          selectedItemColor: orange,
          unselectedItemColor: kGrey,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          unselectedIconTheme: IconThemeData(
            color: kGrey,
            size: 20,
          ),
          selectedIconTheme: IconThemeData(
            color: orange,
            size: 22,
          ),
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
    );
  }
}
