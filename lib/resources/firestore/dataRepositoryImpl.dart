import 'package:budgetplanner/resources/firestore/image_data.dart';
import 'package:budgetplanner/utils/category_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
    ImageData.getBudgetCategoryImageList().forEach((element) {
      if (element.name == name) {
        imageData = element;
      }
    });

    return imageData;
  }
}
