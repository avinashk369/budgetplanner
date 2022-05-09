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
      dismissDirection: DismissDirection.horizontal,
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
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
      backgroundColor: greyColor,
    );
  }

  static getSnanck(String message, String title) {
    return GetBar(
      borderRadius: 10,
      backgroundColor: greyColor,
      dismissDirection: DismissDirection.horizontal,
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
      titleText: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w800,
          fontSize: 16,
        ),
      ),
      messageText: Text(
        message,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w300,
          fontSize: 14,
        ),
      ),
      margin: EdgeInsets.all(15),
      isDismissible: true,
      duration: Duration(seconds: 3),
      message: message,
      title: title,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
