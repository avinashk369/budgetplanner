import 'package:budgetplanner/models/BaseModel.dart';
import 'package:budgetplanner/models/user_model.dart';
import 'package:budgetplanner/resources/firestore/userRepositoryImpl.dart';
import 'package:budgetplanner/utils/PreferenceUtils.dart';
import 'package:budgetplanner/utils/app_constants.dart';
import 'package:budgetplanner/utils/authentication.dart';
import 'package:budgetplanner/utils/route_constants.dart';
import 'package:budgetplanner/utils/styles.dart';
import 'package:budgetplanner/widgets/theme_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GoogleSignInButton extends StatefulWidget {
  @override
  _GoogleSignInButtonState createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  bool _isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: _isSigningIn
          ? Center(
              child: CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(Theme.of(context).hintColor),
              ),
            )
          : ElevatedButton(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size(300, 60)),
                backgroundColor: MaterialStateProperty.all(darkColor),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                elevation: MaterialStateProperty.all(1),
              ),
              onPressed: () async {
                setState(() {
                  _isSigningIn = true;
                });

                User? user =
                    await Authentication.signInWithGoogle(context: context);

                setState(() {
                  _isSigningIn = false;
                });

                if (user != null) {
                  BaseModel<UserModel> userData =
                      await UserRepositoryImpl().getUser(user.uid);
                  if (userData.data!.email != null) {
                    print("Avinash ${userData.data!.name}");
                  } else {
                    UserRepositoryImpl()
                        .createUserInDatabaseWithGoogleProvider(user);
                  }
                  PreferenceUtils.putString(user_id, user.uid);
                  PreferenceUtils.putString(
                      user_name, user.displayName ?? user.email!);
                  PreferenceUtils.putString(
                      creation_time, user.metadata.creationTime.toString());
                  PreferenceUtils.putString(
                      sign_in_time, user.metadata.lastSignInTime.toString());

                  Navigator.popAndPushNamed(context, dashboardRoute);
                }
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image(
                      image: AssetImage("assets/google_logo.png"),
                      height: 30.0,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Sign in with Google',
                        style: kLabelStyle.copyWith(
                            color: whiteColor, fontSize: 18),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
