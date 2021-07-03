import 'package:budgetplanner/screens/user/google_signin_button.dart';
import 'package:budgetplanner/widgets/theme_constants.dart';
import 'package:flutter/material.dart';

class UserLogin extends StatelessWidget {
  const UserLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(
            'assets/firebase_logo.png',
            height: 160,
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: GoogleSignInButton(),
          ),
          Text(
            "One touch sigin",
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
