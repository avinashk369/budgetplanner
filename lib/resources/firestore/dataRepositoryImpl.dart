import 'package:budgetplanner/models/BaseModel.dart';
import 'package:budgetplanner/models/budget_category_model.dart';
import 'package:budgetplanner/models/income_model.dart';
import 'package:budgetplanner/models/saving_category.dart';
import 'package:budgetplanner/resources/firestore/image_data.dart';
import 'package:budgetplanner/utils/category_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'dataRepository.dart';

class DataRepositoryImpl implements DataRepository {
  late FirebaseFirestore _firestore;
  DataRepositoryImpl() {
    _firestore = FirebaseFirestore.instance;
  }
  @override
  Future createBudgetCategory() async {
    List<Map<String, String>> budgetCat = [
      {'name': travel},
      {'name': foodNDrink},
      {'name': shopping},
      {'name': transport},
      {'name': home},
      {'name': billNFee},
      {'name': entertainment},
      {'name': carNMotors},
      {'name': personal},
      {'name': healthcare},
      {'name': education},
      {'name': groceries},
      {'name': gift},
      {'name': sports},
      {'name': beauty},
      {'name': business},
      {'name': others},
    ];

    var batch = _firestore.batch();
    budgetCat.forEach((element) {
      var _mainCollection = _firestore.collection(budgetCategory).doc();
      element['id'] = _mainCollection.id;
      batch.set(_mainCollection, element);
    });
    return batch.commit();
  }

  @override
  Future createIncomeCategory() async {
    List<Map<String, String>> incomeCat = [
      {'name': salary},
      {'name': business},
      {'name': gift},
      {'name': transport},
      {'name': extraIncome},
      {'name': loan},
      {'name': insurancePayout},
      {'name': others},
    ];

    var batch = _firestore.batch();
    incomeCat.forEach((element) {
      var _mainCollection = _firestore.collection(incomeCategory).doc();
      element['id'] = _mainCollection.id;
      batch.set(_mainCollection, element);
    });
    return batch.commit();
  }

  @override
  Future createExpenseType() async {
    List<Map<String, String>> expensetype = [
      {'name': need},
      {'name': want},
    ];

    var batch = _firestore.batch();
    expensetype.forEach((element) {
      var _mainCollection = _firestore.collection(expenseType).doc();
      element['id'] = _mainCollection.id;
      batch.set(_mainCollection, element);
    });
    return batch.commit();
  }

  @override
  Future createRecurrenceType() async {
    List<Map<String, String>> recurranceCat = [
      {'name': never},
      {'name': everyDay},
      {'name': everyWeek},
      {'name': everyThreeMonth},
      {'name': everySixMonth},
      {'name': everyYear},
    ];

    var batch = _firestore.batch();
    recurranceCat.forEach((element) {
      var _mainCollection = _firestore.collection(recurranceCategory).doc();
      element['id'] = _mainCollection.id;
      batch.set(_mainCollection, element);
    });
    return batch.commit();
  }

  @override
  Future createSavingCategory() async {
    List<Map<String, String>> savingCat = [
      {'name': brokerage},
      {'name': retirement},
      {'name': health},
      {'name': education},
      {'name': wedding},
      {'name': emergencyFund},
      {'name': others},
    ];

    var batch = _firestore.batch();
    savingCat.forEach((element) {
      var _mainCollection = _firestore.collection(savingCategory).doc();
      element['id'] = _mainCollection.id;
      batch.set(_mainCollection, element);
    });
    return batch.commit();
  }

  @override
  Future createTransactionType() async {
    List<Map<String, String>> transactionTypeList = [
      {'name': income},
      {'name': expense},
      {'name': saving},
    ];

    var batch = _firestore.batch();
    transactionTypeList.forEach((element) {
      var _mainCollection = _firestore.collection(transactionType).doc();
      element['id'] = _mainCollection.id;
      batch.set(_mainCollection, element);
    });
    return batch.commit();
  }

  @override
  Future clear(String collectionName) async {
    var batch = _firestore.batch();

    var response = await _firestore.collection(collectionName).get();
    response.docs.forEach((element) async {
      batch.delete(_firestore.collection(collectionName).doc(element.id));
    });
    batch.commit();
  }

  ImageData? iconUrl(String name) {
    ImageData? imageData;
    [
      ...ImageData.getIncomeCategoryImageList(),
      ...ImageData.getBudgetCategoryImageList(),
      ...ImageData.getSavingCategoryImageList()
    ].forEach((element) {
      if (element.name == name) {
        imageData = element;
      }
    });

    return imageData;
  }

  @override
  Future createExpenseSource() async {
    List<Map<String, String>> expenseSourceData = [
      {'name': cash},
      {'name': accounts},
      {'name': creditCard},
    ];

    var batch = _firestore.batch();
    expenseSourceData.forEach((element) {
      var _mainCollection = _firestore.collection(expenseSource).doc();
      batch.set(_mainCollection, element);
    });
    return batch.commit();
  }

  /**
   * get list of categories frorm firestore
   */
  @override
  Future<BaseModel<List<BudgetCategoryModel>>> getBudgetCategories() async {
    // TODO: implement testingConnection

    List<BudgetCategoryModel> budgetCategories = [];

    var response = await _firestore.collection(budgetCategory).get();
    budgetCategories = response.docs
        .map((e) => BudgetCategoryModel.fromJson(e.data()))
        .toList();

    // response.docs.forEach((element) async {
    //   BudgetCategoryModel records =
    //       BudgetCategoryModel.fromJson(element.data());
    //   records.id = element.id;
    //   budgetCategories.add(records);
    // });

    return BaseModel()..data = budgetCategories;
  }

  /**
   * get category document by docId
   */
  @override
  Future<BaseModel<BudgetCategoryModel>> getBudgetCategory(String docId) async {
    // TODO: implement testingConnection

    var response = await _firestore.collection(budgetCategory).doc(docId).get();

    return BaseModel()..data = BudgetCategoryModel.fromJson(response.data()!);
  }

  @override
  Future<BaseModel<List<IncomeModel>>> getIncomeCategories() async {
    // TODO: implement testingConnection

    List<IncomeModel> incomeCatList = [];

    var response = await _firestore.collection(incomeCategory).get();
    incomeCatList =
        response.docs.map((e) => IncomeModel.fromJson(e.data())).toList();

    return BaseModel()..data = incomeCatList;
  }

  @override
  Future<BaseModel<List<SavingCategory>>> getSavingCategories() async {
    // TODO: implement testingConnection

    List<SavingCategory> incomeCatList = [];

    var response = await _firestore.collection(savingCategory).get();
    incomeCatList =
        response.docs.map((e) => SavingCategory.fromJson(e.data())).toList();

    return BaseModel()..data = incomeCatList;
  }
}
