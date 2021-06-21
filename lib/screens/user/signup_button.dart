import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpButton extends StatefulWidget {
  final Function() regsiterUser;
  const SignUpButton({
    Key? key,
    required this.regsiterUser,
  }) : super(key: key);

  @override
  _SignUpButtonState createState() => _SignUpButtonState();
}

class _SignUpButtonState extends State<SignUpButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.regsiterUser(),
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
              Color.fromRGBO(143, 148, 251, 1),
              Color.fromRGBO(143, 148, 251, .6),
            ])),
        child: Center(
          child: Text(
            "SIGN UP",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
