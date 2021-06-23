import 'package:budgetplanner/models/BaseModel.dart';
import 'package:budgetplanner/models/user_model.dart';
import 'package:budgetplanner/resources/firestore/userRepositoryImpl.dart';
import 'package:budgetplanner/screens/onboard/onboard_screens.dart';
import 'package:budgetplanner/screens/user/email_signin.dart';
import 'package:budgetplanner/utils/PreferenceUtils.dart';
import 'package:budgetplanner/utils/app_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:budgetplanner/screens/bottom_nav/pages/home.dart';
import 'package:budgetplanner/screens/demo.dart';

import 'dashboard.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  UserRepositoryImpl userRepositoryImpl = UserRepositoryImpl();
  bool hasSeen = false;
  String? userId;
  String? creationTime;
  String? lastSignInTime;
  User? user;
  UserModel? userModel;
  @override
  void initState() {
    // TODO: implement initState
    hasSeen = PreferenceUtils.getBool(has_seen);
    user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      getUser(user!.uid).then((value) {
        userModel = value;
        if (userModel!.email != null) {
          print(userModel!.name);
        } else {
          userRepositoryImpl.createUserInDatabaseWithGoogleProvider(user!);
        }
      });
    }
    userId = PreferenceUtils.getString(user_id);
    creationTime = PreferenceUtils.getString(creation_time);
    lastSignInTime = PreferenceUtils.getString(sign_in_time);
    print(
        "user metadata ${userId} userId \n ${creationTime}  creation time \n ${lastSignInTime}  last sign in time");
    super.initState();
  }

  Future<UserModel> getUser(String uid) async {
    BaseModel<UserModel> user = await userRepositoryImpl.getUser(uid);

    return user.data!;
  }

  void getyser(String userId) async {
    userModel = await getUser("user!.uid");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        pageSnapping: true,
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          (hasSeen)
              ? (userId != '')
                  ? Dashboard()
                  : EmailSignin()
              : OnboardScreen()
        ],
      ),
    );
  }
}
