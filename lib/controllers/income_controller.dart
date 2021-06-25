import 'package:budgetplanner/controllers/base_controller.dart';
import 'package:budgetplanner/models/BaseModel.dart';
import 'package:budgetplanner/models/budget_category_model.dart';
import 'package:budgetplanner/resources/firestore/dataRepositoryImpl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IncomeController extends BaseController {
  var isLoading = true.obs;
  final GlobalKey<FormState> incomeKey = GlobalKey<FormState>();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  late TextEditingController emailController, passwordController;
  late List<BudgetCategoryModel> catList;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    emailController = TextEditingController(text: "a@a.col");
    passwordController = TextEditingController(text: "password");
    // () async {
    //   catList = await getBudgetCategories();
    // }();
    getBudgetCategories().then((value) {
      catList = value;
      catList.obs;
      print("I ma here ${catList.length}");
    });
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

  Future<List<BudgetCategoryModel>> getBudgetCategories() async {
    BaseModel<List<BudgetCategoryModel>>? budgetCategories;

    try {
      isLoading(true);

      budgetCategories = await DataRepositoryImpl().getBudgetCategories();
      print("object ${budgetCategories.data!.length}");
    } catch (e) {} finally {
      Future.delayed(Duration(seconds: 1), () async {
        isLoading(false);
      });
    }

    return budgetCategories!.data!;
  }
}
