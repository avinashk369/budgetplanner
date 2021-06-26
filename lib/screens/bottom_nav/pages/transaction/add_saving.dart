import 'package:budgetplanner/controllers/saving_controller.dart';
import 'package:budgetplanner/screens/user/signin_button.dart';
import 'package:budgetplanner/utils/controller_constants.dart';
import 'package:budgetplanner/widgets/custom_input.dart';
import 'package:budgetplanner/widgets/theme_constants.dart';
import 'package:budgetplanner/widgets/transaction_header.dart';
import 'package:flutter/material.dart';

class AddSaving extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = SavingController.tagged(savingController);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kSpaceS, vertical: kSpaceM),
      child: CustomScrollView(
        controller: ScrollController(),
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Form(
              key: controller.savingKey,
              child: Column(
                children: [
                  TransactionHeader(
                    imageUrl:
                        "https://image.freepik.com/free-vector/rich-people-keeping-cash-clocks-piggy-bank-vector-illustration-time-is-money-business-time-management-wealth-concept_74855-13218.jpg",
                  ),
                  CustomInput(
                    hintText: "Email",
                    controller: controller.emailController,
                    validator: (value) => controller.validateEmail(value!),
                    textInputType: TextInputType.emailAddress,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomInput(
                    controller: controller.passwordController,
                    hintText: 'Password',
                    validator: (value) => controller.validatePassword(value!),
                    isPassword: true,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SigninButton(
                    signinUser: () => controller.modalBottomSheetMenu(
                        context, controller.catList, (value) {
                      Navigator.of(context).pop();
                      print("Call back function $value");
                    }),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
