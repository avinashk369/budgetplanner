import 'package:budgetplanner/screens/user/signin_button.dart';
import 'package:budgetplanner/utils/PreferenceUtils.dart';
import 'package:budgetplanner/utils/app_constants.dart';
import 'package:budgetplanner/utils/authentication.dart';
import 'package:budgetplanner/utils/route_constants.dart';
import 'package:budgetplanner/widgets/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/**
 * this stateful widget class is for testing the 
 * firebase sign up and sign in process using email id and password
 */
class EmailSignin extends StatefulWidget {
  const EmailSignin({Key? key}) : super(key: key);

  @override
  _EmailSigninState createState() => _EmailSigninState();
}

class _EmailSigninState extends State<EmailSignin> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {}
  }

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  var _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.all(Get.height * .03),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  controller: emailController,
                  cursorColor: Theme.of(context).hintColor,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(
                    color: Theme.of(context).hintColor,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter email name!';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Email',
                  ),
                ),
                // SignUpButton(
                //   regsiterUser: () async {
                //     if (!_formKey.currentState!.validate()) {
                //       return;
                //     }
                //     User? user = await Authentication.registerWithEmailPassword(
                //       context: context,
                //       email: emailController.text.toString(),
                //       password: "password",
                //     );
                //     print("${user!.email} registerd user email");
                //   },
                // ),
                SigninButton(
                  signinUser: () async {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }
                    LoadingDialog.showLoadingDialog(context, _keyLoader);
                    Authentication.signinWithEmailPassword(
                      context: context,
                      email: emailController.text.toString(),
                      password: "password",
                    ).then((value) {
                      print("${value!.uid} registerd user id");
                      PreferenceUtils.putString(user_id, value.uid);
                      PreferenceUtils.putString(creation_time,
                          value.metadata.creationTime.toString());
                      PreferenceUtils.putString(sign_in_time,
                          value.metadata.lastSignInTime.toString());
                      Navigator.of(_keyLoader.currentContext!,
                              rootNavigator: true)
                          .pop();
                      Navigator.popAndPushNamed(context, dashboardRoute);
                    });
                  },
                ),
                // TextButton(
                //   onPressed: () async {
                //     await Authentication.sendSigninLink();
                //   },
                //   child: Text("send link"),
                // )
              ],
            ),
          )),
    );
  }
}
