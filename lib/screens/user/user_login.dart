import 'package:budgetplanner/screens/user/google_signin_button.dart';
import 'package:budgetplanner/utils/app_constants.dart';
import 'package:budgetplanner/utils/styles.dart';
import 'package:flutter/material.dart';

class UserLogin extends StatelessWidget {
  const UserLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Image.asset(
                //   'assets/logo1.png',
                //   height: 50,
                // ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  appname.toUpperCase(),
                  textAlign: TextAlign.center,
                  style:
                      kLabelStyleBold.copyWith(fontSize: 20, letterSpacing: 2),
                ),
              ],
            ),
          ),
          Image.asset(
            'assets/fm.jpeg',
          ),
          Spacer(),
          Text(
            "Be finanicially discipline",
            textAlign: TextAlign.center,
            style: kLabelStyleBold.copyWith(
                color: Colors.deepPurple, fontSize: 18, letterSpacing: 1.8),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: GoogleSignInButton(),
          ),
        ],
      ),
    );
  }
}
