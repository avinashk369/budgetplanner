import 'package:budgetplanner/utils/authentication.dart';
import 'package:budgetplanner/utils/route_constants.dart';
import 'package:budgetplanner/widgets/loading_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  late TextEditingController emailController, passwordController;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    emailController = TextEditingController(text: "a@a.col");
    passwordController = TextEditingController(text: "password");
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    emailController.dispose();
    passwordController.dispose();
  }

  String? validateEmail(String email) {
    if (!GetUtils.isEmail(email)) {
      return "Please enter email";
    }
    return null;
  }

  String? validatePassword(String password) {
    if (password.length <= 6) {
      return "Password must be of 6 characters";
    }
    return null;
  }

  void checkLogin(BuildContext context) {
    final isValid = loginKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    LoadingDialog.showLoadingDialog(context, _keyLoader);
    Authentication.signinWithEmailPassword(
      context: context,
      email: emailController.text.toString(),
      password: "password",
    ).then((value) {
      print("${value!.uid} registerd user id ${value.emailVerified}");
      Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
      // if (!value.emailVerified) {
      //   Get.dialog(
      //     MyAlertDialog(
      //       title: Container(),
      //       content: Text('verification-email-sent-message'.tr),
      //       actions: [
      //         TextButton(
      //           onPressed: () => Get.back(),
      //           child: Text(
      //             'Ok',
      //             style: TextStyle(
      //               color: Color(0xFF39bc26),
      //             ),
      //           ),
      //         )
      //       ],
      //     ),
      //   );
      // } else {
      Navigator.popAndPushNamed(context, dashboardRoute);
      //}
    });
  }
}

class MyAlertDialog extends GetView {
  final Widget title;
  final Widget content;
  final List<Widget>? actions;

  MyAlertDialog({required this.title, required this.content, this.actions});

  @override
  Widget build(BuildContext context) {
    return GetPlatform.isAndroid
        ? AlertDialog(
            title: title,
            content: content,
            actions: actions,
          )
        : CupertinoAlertDialog(
            title: title,
            content: content,
            actions: actions ?? [],
          );
  }
}
