import 'package:budgetplanner/controllers/transaction_controller.dart';
import 'package:budgetplanner/resources/firestore/image_data.dart';
import 'package:budgetplanner/screens/user/signin_button.dart';
import 'package:budgetplanner/utils/controller_constants.dart';
import 'package:budgetplanner/widgets/theme_constants.dart';
import 'package:budgetplanner/widgets/transaction_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddSaving extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TransactionEntryController controller =
        Get.find<TransactionEntryController>(tag: savingController);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kSpaceS, vertical: kSpaceM),
      child: CustomScrollView(
        controller: ScrollController(),
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Form(
              key: controller.savingKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  TransactionHeader(
                    imageUrl:
                        "https://image.freepik.com/free-vector/rich-people-keeping-cash-clocks-piggy-bank-vector-illustration-time-is-money-business-time-management-wealth-concept_74855-13218.jpg",
                  ),
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
                    signinUser: () => controller.modalBottomSheetMenu(
                        context, ImageData.getSavingCategoryImageList(),
                        (value) {
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
