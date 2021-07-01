import 'package:budgetplanner/models/BaseModel.dart';
import 'package:budgetplanner/models/budget_category_model.dart';
import 'package:budgetplanner/models/budget_model.dart';
import 'package:budgetplanner/models/expense_source_model.dart';
import 'package:budgetplanner/models/income_model.dart';
import 'package:budgetplanner/models/recurrance_model.dart';
import 'package:budgetplanner/models/saving_category.dart';
import 'package:budgetplanner/models/transaction_model.dart';
import 'package:budgetplanner/models/transaction_type_model.dart';
import 'package:budgetplanner/resources/firestore/image_data.dart';
import 'package:budgetplanner/utils/category_constants.dart';
import 'package:budgetplanner/utils/string_constants.dart';
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

  @override
  Future<BaseModel<List<TransactionType>>> getTransactionType() async {
    // TODO: implement testingConnection

    List<TransactionType> transactionTypeList = [];

    var response = await _firestore.collection(transactionType).get();
    transactionTypeList =
        response.docs.map((e) => TransactionType.fromJson(e.data())).toList();

    return BaseModel()..data = transactionTypeList;
  }

  @override
  Future<BaseModel<List<RecurranceModel>>> getRecurranceType() async {
    // TODO: implement testingConnection

    List<RecurranceModel> recurranceTypeList = [];

    var response = await _firestore.collection(recurranceCategory).get();
    recurranceTypeList =
        response.docs.map((e) => RecurranceModel.fromJson(e.data())).toList();

    return BaseModel()..data = recurranceTypeList;
  }

  @override
  Future saveTransaction(TransactionModel transactionModel) async {
    var _mainCollection = _firestore.collection(transaction).doc();
    transactionModel.id = _mainCollection.id;
    await _mainCollection
        .set(transactionModel.toJson())
        .whenComplete(() => print('Transaction added successfully!'))
        .catchError((error) {
      print(error.toString());
    });
  }

  @override
  Future<BaseModel<List<ExpenseSourceModel>>> getExpenseSource() async {
    // TODO: implement testingConnection

    List<ExpenseSourceModel> expenseSourceList = [];

    var response = await _firestore.collection(expenseSource).get();
    expenseSourceList = response.docs
        .map((e) => ExpenseSourceModel.fromJson(e.data()))
        .toList();

    return BaseModel()..data = expenseSourceList;
  }

  @override
  Stream<List<TransactionModel>>? getTransactions(
      String userId, String transactionType) async* {
    try {
      yield* _firestore
          .collection(transaction)
          //.where('transacion_type', isGreaterThanOrEqualTo: transactionType)
          .where('user_id', isEqualTo: userId)
          // .where('created_on', isLessThanOrEqualTo: DateTime.now())
          // .orderBy('created_on')
          .snapshots()
          .map((query) {
        return query.docs.map((doc) {
          return TransactionModel.fromJson(doc.data());
        }).toList();
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Future<double> getTotalIncome(String monthName) async {
    // TODO: implement testingConnection

    double totalIncome = 0.0;

    return totalIncome;
  }

  Stream<BaseModel<List<TransactionModel>>> todoStream(
      String transactionType) async* {
    // TODO: implement testingConnection

    List<TransactionModel> transactionList = [];
    try {
      var response = await _firestore
          .collection(transaction)
          .where('transacion_type', isGreaterThanOrEqualTo: transactionType)
          .get();
      transactionList = response.docs
          .map((e) => TransactionModel.fromJson(e.data()))
          .toList();
      print("kumar ${transactionList.length}");
    } catch (e) {
      print("exception ${e.toString()}");
    }

    yield BaseModel()..data = transactionList;
  }

  Stream<List<TransactionModel>> getTodos() {
    var date = DateTime.now();

    return _firestore
        .collection(transaction)
        // .where('created_on',
        //     isGreaterThanOrEqualTo: new DateTime(date.year, date.month, 1))
        // .orderBy('created_on', descending: false)
        .snapshots()
        .map((query) {
      return query.docs.map((doc) {
        return TransactionModel.fromJson(doc.data());
      }).toList();
    });
  }

  @override
  Future deleteTransaction(String id) async {
    try {
      await _firestore.collection(transaction).doc(id).delete();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> updateTransaction(TransactionModel transactionModel) async {
    try {
      await _firestore
          .collection(transaction)
          .doc(transactionModel.id)
          .update(transactionModel.toJson());
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> updateBudget(BudgetModel budgetModel) async {
    try {
      await _firestore
          .collection(userBudget)
          .doc(budgetModel.id)
          .update(budgetModel.toJson());
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  Future saveBudget(BudgetModel budgetModel) async {
    var _mainCollection = _firestore.collection(userBudget).doc();
    budgetModel.id = _mainCollection.id;
    await _mainCollection
        .set(budgetModel.toJson())
        .whenComplete(() => print('Transaction added successfully!'))
        .catchError((error) {
      print(error.toString());
    });
  }

  @override
  Stream<List<TransactionModel>>? getRecentTransactions(String userId) async* {
    try {
      yield* _firestore
          .collection(transaction)
          .where('user_id', isEqualTo: userId)
          .limit(5)
          .snapshots()
          .map((query) {
        return query.docs.map((doc) {
          return TransactionModel.fromJson(doc.data());
        }).toList();
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Stream<List<BudgetModel>>? getBudgetList(String userId) async* {
    try {
      yield* _firestore
          .collection(userBudget)
          .where('user_id', isEqualTo: userId)
          .snapshots()
          .map((query) {
        return query.docs.map((doc) {
          return BudgetModel.fromJson(doc.data());
        }).toList();
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Future deleteBudget(String id) async {
    try {
      await _firestore.collection(userBudget).doc(id).delete();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<BudgetModel?> getBudgetModel(String name) async {
    BudgetModel? budgetModel;
    var response = await _firestore
        .collection(userBudget)
        .where('cat_name', isEqualTo: name)
        .get();
    print("${response.docs.length} response");
    if (response.docs.length > 0)
      budgetModel = BudgetModel.fromJson(response.docs.first.data());
    return budgetModel;
  }

  Stream<List<BudgetModel>> listAllBudget() async* {
    List<BudgetModel> budgetModelList = [];
    yield* _firestore.collection(userBudget).snapshots().map((query) {
      return query.docs.map((doc) {
        //return getBudgetDetail(BudgetModel.fromJson(doc.data()))!;
        BudgetModel budget = BudgetModel.fromJson(doc.data());
        _firestore
            .collection(transaction)
            .where("cat_name", isEqualTo: budget.catName)
            .get()
            .then((value) {
          double totalAMount = 0.0;
          value.docs.forEach((element) {
            TransactionModel transactionModel =
                TransactionModel.fromJson(element.data());
            totalAMount += transactionModel.amount!;
          });
          budget.totalExpense = totalAMount;
        });
        return budget;
      }).toList();
    });
  }

  BudgetModel? getBudgetDetail(BudgetModel budgetModel) {
    _firestore
        .collection(transaction)
        .where("cat_name", isEqualTo: budgetModel.catName)
        .get()
        .then((value) {
      double totalAMount = 0.0;
      value.docs.forEach((element) {
        TransactionModel transactionModel =
            TransactionModel.fromJson(element.data());

        totalAMount += transactionModel.amount!;
      });
      budgetModel.totalExpense = totalAMount;
      print(
          "${budgetModel.catName} Printing amount in ${budgetModel.totalExpense}");
    });
    return budgetModel;
  }
}
