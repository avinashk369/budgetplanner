import 'package:budgetplanner/models/BaseModel.dart';
import 'package:budgetplanner/models/user_model.dart';
import 'package:budgetplanner/resources/firestore/userRepositoryImpl.dart';
import 'package:budgetplanner/screens/crud/fire_crud.dart';
import 'package:budgetplanner/screens/onboard/onboard_screens.dart';
import 'package:budgetplanner/screens/user/user_login.dart';
import 'package:budgetplanner/utils/PreferenceUtils.dart';
import 'package:budgetplanner/utils/app_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
    // Create anonymous function:
    if (user != null) {
      () async {
        BaseModel<UserModel> userData =
            await userRepositoryImpl.getUser(user!.uid);
        if (userData.data!.email != null) {
          print("Avinash ${userData.data!.name}");
        } else {
          userRepositoryImpl.createUserInDatabaseWithGoogleProvider(user!);
        }
      }();
    }

    // if (user != null) {
    //   getUser(user!.uid).then((value) {
    //     userModel = value;
    //     if (userModel!.email != null) {
    //       print(userModel!.name);
    //     } else {
    //       userRepositoryImpl.createUserInDatabaseWithGoogleProvider(user!);
    //     }
    //   });
    // }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (hasSeen)
          ? (userId!.isNotEmpty)
              ? Dashboard()
              : UserLogin() //EmailSingIn()
          : OnboardScreen(),
    );
  }
}
