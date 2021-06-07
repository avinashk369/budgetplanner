import 'package:flutter/material.dart';
import 'package:budgetplanner/screens/bottom_nav/pages/home.dart';
import 'package:budgetplanner/screens/demo.dart';

import 'dashboard.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  bool hasSeen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        pageSnapping: true,
        scrollDirection: Axis.horizontal,
        children: <Widget>[(hasSeen) ? Dashboard() : Dashboard()],
      ),
    );
  }
}
