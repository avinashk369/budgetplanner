import 'dart:math';

import 'package:budgetplanner/resources/firestore/image_data.dart';
import 'package:budgetplanner/utils/authentication.dart';
import 'package:budgetplanner/utils/route_constants.dart';
import 'package:budgetplanner/utils/styles.dart';
import 'package:budgetplanner/widgets/_ModalBottomSheetLayout.dart';
import 'package:budgetplanner/widgets/loading_dialog.dart';
import 'package:budgetplanner/widgets/theme_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionEntryController extends GetxController {
  final GlobalKey<FormState> incomeKey = GlobalKey<FormState>();
  final GlobalKey<FormState> expenseKey = GlobalKey<FormState>();
  final GlobalKey<FormState> savingKey = GlobalKey<FormState>();

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
    final isValid = incomeKey.currentState!.validate();
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

  void modalBottomSheetMenu(
      BuildContext context, List<ImageData> imageList, Function iconClicked) {
    ;
    Random random = new Random();
    showModalBottomSheetApp(
        dismissOnTap: true,
        context: context,
        builder: (builder) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Flexible(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 30 / 27,
                    ),
                    itemCount: imageList.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            margin: EdgeInsets.only(bottom: 5),
                            decoration: BoxDecoration(
                              color: imageList[index].colorName,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                            ),
                            child: IconButton(
                              padding: EdgeInsets.all(0),
                              icon: Icon(
                                imageList[index].iconName,
                                size: 40,
                                color: whiteColor,
                              ),
                              onPressed: () {
                                //Navigator.of(context).pop();
                                iconClicked(imageList[index].name);
                              },
                            ),
                          ),
                          Text(
                            imageList[index].name,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              )
            ],
          );
        },
        statusBarHeight: Get.height * .5);
  }
}
