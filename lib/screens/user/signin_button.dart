import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SigninButton extends GetView {
  final Function() signinUser;
  const SigninButton({Key? key, required this.signinUser}) : super(key: key);

  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => signinUser(),
      child: Container(
        margin: EdgeInsets.only(
            left: Get.height * .03,
            right: Get.height * .03,
            top: Get.height * .03),
        height: Get.height * .1,
        width: Get.width * 1,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(colors: [
              Color.fromRGBO(143, 148, 251, 3),
              Color.fromRGBO(143, 148, 251, .3),
            ])),
        child: Center(
          child: Text(
            "SIGN IN",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
