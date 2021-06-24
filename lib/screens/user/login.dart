import 'package:budgetplanner/controllers/login_controller.dart';
import 'package:budgetplanner/screens/user/signin_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class Login extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.fromLTRB(8, 10, 8, 10),
          width: Get.width,
          height: Get.height,
          child: SingleChildScrollView(
            child: Form(
              key: controller.loginKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.emailController,
                    validator: (value) {
                      return controller.validateEmail(value!);
                    },
                    cursorColor: Theme.of(context).hintColor,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                      color: Theme.of(context).hintColor,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Email',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: controller.passwordController,
                    validator: (value) {
                      return controller.validatePassword(value!);
                    },
                    cursorColor: Theme.of(context).hintColor,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                      color: Theme.of(context).hintColor,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Password',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SigninButton(
                    signinUser: () => controller.checkLogin(context),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
