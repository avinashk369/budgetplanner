import 'package:budgetplanner/screens/user/signin_button.dart';
import 'package:budgetplanner/screens/user/signup_button.dart';
import 'package:budgetplanner/utils/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
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
    if (state == AppLifecycleState.resumed) {
      initDynamicLinks();
    }
  }

  Future<void> initDynamicLinks() async {
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData? dynamicLink) async {
      final Uri? deepLink = dynamicLink?.link;

      if (deepLink != null) {
        print("deep link path ${deepLink.path}");
        // ignore: unawaited_futures
        //Navigator.pushNamed(context, deepLink.path);
        //Get.off(DynamicLinkScreen());
      }
    }, onError: (OnLinkErrorException e) async {
      print('onLinkError');
      print(e.message);
    });

    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri? deepLink = data?.link;

    if (deepLink != null) {
      // ignore: unawaited_futures
      print("deep link path  data${deepLink.path}");
      //Navigator.pushNamed(context, deepLink.path);
    }
  }

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
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter email name!';
                    }
                    return null;
                  },
                  decoration: InputDecoration(hintText: 'Email'),
                ),
                SignUpButton(
                  regsiterUser: () async {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }
                    User? user = await Authentication.registerWithEmailPassword(
                      context: context,
                      email: emailController.text.toString(),
                      password: "password",
                    );
                    print("${user!.email} registerd user email");
                  },
                ),
                SigninButton(
                  signinUser: () async {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }
                    User? user = await Authentication.signinWithEmailPassword(
                      context: context,
                      email: emailController.text.toString(),
                      password: "password",
                    );
                    print("${user!.email} registerd user email");
                  },
                ),
                TextButton(
                    onPressed: () async {
                      await Authentication.sendSigninLink();
                    },
                    child: Text("send link"))
              ],
            ),
          )),
    );
  }
}
