import 'package:budgetplanner/controllers/base_controller.dart';
import 'package:budgetplanner/models/BaseModel.dart';
import 'package:budgetplanner/models/budget_category_model.dart';
import 'package:budgetplanner/models/income_model.dart';
import 'package:budgetplanner/models/saving_category.dart';
import 'package:budgetplanner/resources/firestore/dataRepositoryImpl.dart';
import 'package:budgetplanner/widgets/_ModalBottomSheetLayout.dart';
import 'package:budgetplanner/widgets/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SavingController extends BaseController {
  var isLoading = true.obs;
  final GlobalKey<FormState> savingKey = GlobalKey<FormState>();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  late TextEditingController emailController, passwordController;
  late List<SavingCategory> catList;
  static SavingController get to => Get.find<SavingController>();
  static SavingController tagged(String name) =>
      Get.find<SavingController>(tag: name);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    () async {
      catList = await getSavingCategories();
    }();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    emailController.dispose();
    passwordController.dispose();
  }

  String? validateEmail(String email) {
    if (!GetUtils.isEmail(email)) {
      return "Please enter email";
    }
    return null;
  }

  String? validatePassword(String password) {
    if (password.length <= 6) {
      return "Password must be of 6 characters";
    }
    return null;
  }

  Future<List<SavingCategory>> getSavingCategories() async {
    BaseModel<List<SavingCategory>>? budgetCategories;

    try {
      isLoading(true);

      budgetCategories = await DataRepositoryImpl().getSavingCategories();
      print("object ${budgetCategories.data!.length}");
    } catch (e) {} finally {
      Future.delayed(Duration(seconds: 1), () async {
        isLoading(false);
      });
    }

    return budgetCategories!.data!;
  }

  void modalBottomSheetMenu(
      BuildContext context,
      List<SavingCategory> imageList,
      Function(SavingCategory savingCategoryModel) iconClicked) {
    showModalBottomSheetApp(
        dismissOnTap: true,
        context: context,
        builder: (builder) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Flexible(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 30 / 27,
                    ),
                    itemCount: imageList.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            height: 55,
                            width: 55,
                            margin: EdgeInsets.only(bottom: 5),
                            decoration: BoxDecoration(
                              color: DataRepositoryImpl()
                                  .iconUrl(imageList[index].name!)!
                                  .colorName,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                            ),
                            child: IconButton(
                              padding: EdgeInsets.all(0),
                              icon: Icon(
                                DataRepositoryImpl()
                                    .iconUrl(imageList[index].name!)!
                                    .iconName,
                                size: 35,
                                color: whiteColor,
                              ),
                              onPressed: () {
                                //Navigator.of(context).pop();

                                iconClicked(imageList[index]);
                              },
                            ),
                          ),
                          Text(
                            imageList[index].name!,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              )
            ],
          );
        },
        statusBarHeight: Get.height * .5);
  }
}
