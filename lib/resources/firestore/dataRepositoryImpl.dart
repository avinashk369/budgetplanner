import 'package:cloud_firestore/cloud_firestore.dart';

import 'dataRepository.dart';

class DataRepositoryImpl implements DataRepository {
  late FirebaseFirestore _firestore;
  DataRepositoryImpl() {
    _firestore = FirebaseFirestore.instance;
  }
  @override
  void createBudgetCategory() async {
    List<Map<String, String>> budgetCat = [
      {'name': 'Travel'},
      {'name': 'Food & Drink'},
      {'name': 'Shopping'},
      {'name': 'Transport'},
      {'name': 'Home'},
      {'name': 'Bills & Fees'},
      {'name': 'Entertainment'},
      {'name': 'Car & Motors'},
      {'name': 'Personal'},
      {'name': 'HealthCare'},
      {'name': 'Education'},
      {'name': 'Groceries'},
      {'name': 'Gift'},
      {'name': 'Sports'},
      {'name': 'Beauty'},
      {'name': 'Business'},
      {'name': 'Others'},
    ];

    var batch = _firestore.batch();
    budgetCat.forEach((element) {
      var _mainCollection = _firestore.collection('budgetCategory').doc();
      batch.set(_mainCollection, element);
      print("Saving document");
    });
    return batch.commit();
  }

  @override
  void createIncomeCategory() async {
    List<Map<String, String>> incomeCat = [
      {'name': 'Salary'},
      {'name': 'Business'},
      {'name': 'Gifts'},
      {'name': 'Transport'},
      {'name': 'Extra Income'},
      {'name': 'Loan'},
      {'name': 'Insurance Payout'},
      {'name': 'Others'},
    ];

    var batch = _firestore.batch();
    incomeCat.forEach((element) {
      var _mainCollection = _firestore.collection('incomeCategory').doc();
      batch.set(_mainCollection, element);
    });
    return batch.commit();
  }

  @override
  void createExpenseType() async {
    List<Map<String, String>> expensetype = [
      {'name': 'Need'},
      {'name': 'Want'},
    ];

    var batch = _firestore.batch();
    expensetype.forEach((element) {
      var _mainCollection = _firestore.collection('expenseType').doc();
      batch.set(_mainCollection, element);
    });
    return batch.commit();
  }

  @override
  void createRecurrenceType() async {
    List<Map<String, String>> recurranceCat = [
      {'name': 'Never'},
      {'name': 'Everyday'},
      {'name': 'Every Week'},
      {'name': 'Every 3 Months'},
      {'name': 'Every 6 Months'},
      {'name': 'Every Year'},
    ];

    var batch = _firestore.batch();
    recurranceCat.forEach((element) {
      var _mainCollection = _firestore.collection('recurranceCategory').doc();
      batch.set(_mainCollection, element);
    });
    return batch.commit();
  }

  @override
  void createSavingCategory() async {
    List<Map<String, String>> savingCat = [
      {'name': 'Brokerage'},
      {'name': 'Retirement'},
      {'name': 'Health'},
      {'name': 'Education'},
      {'name': 'Wedding'},
      {'name': 'Emergency'},
      {'name': 'Others'},
    ];

    var batch = _firestore.batch();
    savingCat.forEach((element) {
      var _mainCollection = _firestore.collection('savingCategory').doc();
      batch.set(_mainCollection, element);
    });
    return batch.commit();
  }

  @override
  void createTransactionType() async {
    List<Map<String, String>> transactionType = [
      {'name': 'Income'},
      {'name': 'Expense'},
      {'name': 'Saving'},
    ];

    var batch = _firestore.batch();
    transactionType.forEach((element) {
      var _mainCollection = _firestore.collection('transactionType').doc();

      batch.set(_mainCollection, element);
    });
    return batch.commit();
  }

  @override
  void clear(String collectionName) async {
    var batch = _firestore.batch();

    var response = await _firestore.collection(collectionName).get();
    response.docs.forEach((element) async {
      batch.delete(_firestore.collection(collectionName).doc(element.id));
    });
    batch.commit();
  }
}
