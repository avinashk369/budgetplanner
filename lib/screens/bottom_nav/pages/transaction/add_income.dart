import 'package:budgetplanner/controllers/income_controller.dart';
import 'package:budgetplanner/resources/firestore/dataRepositoryImpl.dart';
import 'package:budgetplanner/utils/controller_constants.dart';
import 'package:budgetplanner/widgets/theme_constants.dart';
import 'package:budgetplanner/widgets/transaction_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddIncome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = IncomeController.tagged(incomeController);
    if (!controller.isLoading())
      print("cat list size ${controller.catList.length}");
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kSpaceS, vertical: kSpaceM),
      child: CustomScrollView(
        controller: ScrollController(),
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Form(
              key: controller.incomeKey,
              child: Column(
                children: [
                  TransactionHeader(
                    imageUrl:
                        "https://image.freepik.com/free-vector/stock-market-investing-online-monetization-remote-job-freelance-work_335657-3022.jpg",
                  ),
                  InkWell(
                    onTap: () {
                      controller.modalBottomSheetMenu(
                        context,
                        controller.catList,
                        (value) {
                          Navigator.of(context).pop();
                          print("Call back function ${value.name}");
                        },
                      );
                    },
                    child: Container(
                      height: 56,
                      width: Get.width,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color:
                                  Theme.of(context).hintColor.withOpacity(.12),
                              width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            flex: 1,
                            child: Obx(() => Text(
                                controller.incomeModel.value.name ??
                                    "Select category")),
                          ),
                          Flexible(
                            flex: 1,
                            child: Obx(
                                () => controller.incomeModel.value.name != null
                                    ? Icon(
                                        DataRepositoryImpl()
                                            .iconUrl(controller
                                                .incomeModel.value.name!)!
                                            .iconName,
                                        color: whiteColor,
                                      )
                                    : Icon(Icons.ac_unit)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: controller.emailController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    autovalidateMode: AutovalidateMode.onUserInteraction,
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
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
