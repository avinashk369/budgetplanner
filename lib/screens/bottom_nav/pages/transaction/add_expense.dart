import 'package:budgetplanner/controllers/expense_controller.dart';
import 'package:budgetplanner/controllers/transaction_controller.dart';
import 'package:budgetplanner/resources/firestore/image_data.dart';
import 'package:budgetplanner/screens/user/signin_button.dart';
import 'package:budgetplanner/utils/controller_constants.dart';
import 'package:budgetplanner/widgets/theme_constants.dart';
import 'package:budgetplanner/widgets/transaction_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddExpense extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = ExpenseController.tagged(expenseController);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kSpaceS, vertical: kSpaceM),
      child: CustomScrollView(
        controller: ScrollController(),
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Form(
              key: controller.expenseKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  TransactionHeader(
                    imageUrl:
                        "https://image.freepik.com/free-vector/tiny-people-trap-credit-card-debt-flat-illustration_74855-11110.jpg",
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
                        context, controller.catList, (value) {
                      Navigator.of(context).pop();
                      print("Call back function ${value.name}");
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
