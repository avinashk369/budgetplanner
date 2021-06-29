import 'dart:convert';

import 'package:budgetplanner/models/BaseModel.dart';
import 'package:budgetplanner/models/budget_category_model.dart';
import 'package:budgetplanner/models/user_model.dart';
import 'package:budgetplanner/resources/firestore/dataRepositoryImpl.dart';
import 'package:budgetplanner/resources/firestore/userRepositoryImpl.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_rx/get_rx.dart';

class TestController extends GetxController {
  var counter = 0.obs;
  var isLoading = true.obs;

  void increment() => counter.value++;

  Future<UserModel> getUserDetail(String userId) async {
    BaseModel<UserModel>? userData;
    try {
      isLoading(true);

      userData =
          await UserRepositoryImpl().getUser("wyly5t8m8yTisWgEUA6BDRbd7xp2");
      userData.obs;
    } catch (e) {} finally {
      Future.delayed(Duration(seconds: 3), () async {
        isLoading(false);
      });
    }

    return userData!.data!;
  }

  Future<List<BudgetCategoryModel>> getBudgetCategories() async {
    BaseModel<List<BudgetCategoryModel>>? budgetCategories;
    List<BudgetCategoryModel> demo = [
      BudgetCategoryModel()..id = "1",
      BudgetCategoryModel()..id = "2",
      BudgetCategoryModel()..id = "3",
      BudgetCategoryModel()..id = "4",
      BudgetCategoryModel()..id = "5",
      BudgetCategoryModel()..id = "6",
      BudgetCategoryModel()..id = "7",
    ];

    print(" json string value ${jsonEncode(demo)}");

    List<BudgetCategoryModel> demo1;
    demo1 = (jsonDecode(jsonEncode(demo)) as List)
        .map((i) => BudgetCategoryModel.fromJson(i))
        .toList();

    print("json decode list size ${demo1.length}");
    try {
      isLoading(true);

      budgetCategories = await DataRepositoryImpl().getBudgetCategories();
      budgetCategories.obs;
    } catch (e) {} finally {
      Future.delayed(Duration(seconds: 1), () async {
        isLoading(false);
      });
    }

    return budgetCategories!.data!;
  }

  Future<BudgetCategoryModel> getCategory() async {
    BaseModel<BudgetCategoryModel>? budgetCategories;
    try {
      isLoading(true);

      budgetCategories =
          await DataRepositoryImpl().getBudgetCategory("z2tu0fdmFVc2TtYG73E7");
      budgetCategories.obs;
    } catch (e) {} finally {
      Future.delayed(Duration(seconds: 1), () async {
        isLoading(false);
      });
    }

    return budgetCategories!.data!;
  }
}
