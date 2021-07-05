import 'package:budgetplanner/screens/user/google_signin_button.dart';
import 'package:budgetplanner/utils/app_constants.dart';
import 'package:budgetplanner/utils/styles.dart';
import 'package:budgetplanner/widgets/theme_constants.dart';
import 'package:flutter/material.dart';

class UserLogin extends StatelessWidget {
  const UserLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 30,
          ),
          Column(
            children: [
              Image.asset(
                'assets/logo1.png',
                height: 120,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                appname,
                textAlign: TextAlign.center,
                style: kLabelStyleBold.copyWith(color: tealColor, fontSize: 20),
              ),
            ],
          ),
          Center(
            child: GoogleSignInButton(),
          ),
          Text(
            "One touch sign in".toUpperCase(),
            textAlign: TextAlign.center,
            style: kTitleStyleSmall.copyWith(color: darkColor, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
