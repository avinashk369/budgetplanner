import 'package:budgetplanner/controllers/test_controller.dart';
import 'package:budgetplanner/controllers/transaction_controller.dart';
import 'package:budgetplanner/models/BaseModel.dart';
import 'package:budgetplanner/models/budget_category_model.dart';
import 'package:budgetplanner/models/user_model.dart';
import 'package:budgetplanner/resources/firestore/userRepositoryImpl.dart';
import 'package:budgetplanner/widgets/snack_bar.dart';
import 'package:budgetplanner/widgets/theme_constants.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:budgetplanner/utils/app_constants.dart';
import 'package:budgetplanner/widgets/config.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserRepositoryImpl userRepositoryImpl = UserRepositoryImpl();
  final controller2 = TransactionEntryController.to;
  TestController controller = Get.find<TestController>();
  TestController controller1 = Get.find<TestController>(tag: "buttonEvent");
  UserModel? userModel;
  @override
  void initState() {
    // TODO: implement initState
    getUserData();
    super.initState();
  }

  void getUserData() async {
    userModel = await controller.getUserDetail();
    print("User info ${userModel!.email}");
  }

  Future<UserModel> getUser() async {
    BaseModel<UserModel> user =
        await userRepositoryImpl.getUser("wyly5t8m8yTisWgEUA6BDRbd7xp2");
    print(user.data!.email);
    return user.data!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 6.0),
              child: CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage("${course_image_url}"
                    "logo.jpeg"),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  top: 4.0,
                ),
                child: IconButton(
                    icon: Icon(
                      EvaIcons.bellOutline,
                      size: 20,
                    ),
                    //color: kWhite,
                    onPressed: () {
                      currentTheme.toggleTheme();
                    }),
              ),
            ],
          ),
        ],
      ),
      body: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // ElevatedButton(
            //   child: Text('Patrol'),
            //   onPressed: () async {
            //     // List<BudgetCategoryModel> categories =
            //     //     await controller1.getBudgetCategories();
            //     // categories.forEach((element) {
            //     //   //print("Id ${element.id} name ${element.name}");
            //     // });
            //     // BudgetCategoryModel catModel = await controller1.getCategory();
            //     // print("Id ${catModel.id} name ${catModel.name}");
            //     // SnackBarDialog.displaySuccessSnackbar(
            //     //   "Transaction",
            //     //   "Income added successfully!",
            //     // );
            //   },
            // ),
            Text(
              "Hello",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Obx(
              () => (controller.isLoading())
                  ? CircularProgressIndicator(
                      color: Theme.of(context).hintColor,
                      strokeWidth: 2,
                    )
                  : Text('${userModel!.email}'),
            ),
          ],
        ),
      ),
    );
  }
}
