import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'theme_constants.dart';

class SnackBarDialog {
  static displaySnackbar(String title, String message) {
    return Get.snackbar(
      title,
      "Please select income source",
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.all(15),
      isDismissible: true,
      dismissDirection: SnackDismissDirection.HORIZONTAL,
      forwardAnimationCurve: Curves.easeOutBack,
      backgroundColor: redColor,
    );
  }
}
