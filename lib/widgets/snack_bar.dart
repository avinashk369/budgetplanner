import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'theme_constants.dart';

class SnackBarDialog {
  static displaySnackbar(String title, String message) {
    return Get.snackbar(
      title,
      message,
      colorText: whiteColor,
      icon: Container(
        margin: EdgeInsets.only(left: 5),
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: whiteColor,
        ),
        child: Icon(
          Icons.warning,
          color: redColor,
          size: 20,
        ),
      ),
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.all(15),
      isDismissible: true,
      dismissDirection: SnackDismissDirection.HORIZONTAL,
      forwardAnimationCurve: Curves.easeOutBack,
      backgroundColor: redColor,
    );
  }

  static displaySuccessSnackbar(String title, String message) {
    return Get.snackbar(
      title,
      message,
      colorText: darkColor,
      icon: Container(
        margin: EdgeInsets.only(left: 5),
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: greenbuttoncolor,
        ),
        child: Icon(
          Icons.assignment_turned_in,
          color: whiteColor,
          size: 20,
        ),
      ),
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.all(15),
      isDismissible: true,
      dismissDirection: SnackDismissDirection.HORIZONTAL,
      forwardAnimationCurve: Curves.easeOutBack,
      backgroundColor: greyColor,
    );
  }
}
