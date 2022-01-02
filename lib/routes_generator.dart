import 'package:budgetplanner/SlideRightRoute.dart';
import 'package:budgetplanner/screens/bottom_nav/pages/transaction/transaction.dart';
import 'package:budgetplanner/screens/dashboard.dart';
import 'package:budgetplanner/screens/user/email_signin.dart';
import 'package:flutter/material.dart';

import 'screens/welcome.dart';
import 'utils/route_constants.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    print("${settings.name} settings route name");
    switch (settings.name) {
      case homeRoute:
        //Welcome()
        return SlideRightRoute(page: Welcome());
      case loginRoute:
        return SlideRightRoute(page: EmailSignin());

      case dashboardRoute:
        return SlideRightRoute(page: Dashboard());
      case addTransactionRoute:
        return SlideRightRoute(page: Transaction());
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
