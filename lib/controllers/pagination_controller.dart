import 'package:budgetplanner/models/budget_category_model.dart';
import 'package:budgetplanner/models/transaction_model.dart';
import 'package:budgetplanner/models/transaction_type_model.dart';
import 'package:budgetplanner/utils/PreferenceUtils.dart';
import 'package:budgetplanner/utils/app_constants.dart';
import 'package:budgetplanner/utils/category_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class PaginationController extends GetxController {
  late FirebaseFirestore _firestore;
  List<TransactionModel> get transactionList => paginatedList.value;
  Rx<List<TransactionModel>> transactionModel = Rx<List<TransactionModel>>([]);
  Rx<List<BudgetCategoryModel>> bcm = Rx<List<BudgetCategoryModel>>([]);
  static PaginationController get to => Get.find<PaginationController>();
  static PaginationController tagged(String name) =>
      Get.find<PaginationController>(tag: name);
  var initialLoad = true.obs;
  var isFinished = false.obs;
  var isLoading = true.obs;
  late DocumentSnapshot lastFetchedSnapshot;
  Rx<List<DocumentSnapshot>> lastDoc = Rx<List<DocumentSnapshot>>([]);
  Rx<List<DocumentSnapshot>> transactionSnapshot =
      Rx<List<DocumentSnapshot>>([]);
  Rx<List<TransactionModel>> paginatedList = Rx<List<TransactionModel>>([]);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _firestore = FirebaseFirestore.instance;
  }

  Stream<List<TransactionModel>>? getFirst() async* {
    try {
      String userId = PreferenceUtils.getString(user_id);
      isLoading(true);
      // var response = PaginationRepoImpl()
      //     .getTransactions(userId, transactionType, DateTime.now(), []);
      // List<TransactionModel> tlist =
      //     response.then((value) => value!.docs.map((element) {
      //           return TransactionModel.fromJson(element.data());
      //         }).toList()) as List<TransactionModel>;
      // yield tlist;
    } catch (e) {
    } finally {
      isLoading(false);
    }
  }

  Stream<List<TransactionModel>>? getNext() async* {
    try {
      String userId = PreferenceUtils.getString(user_id);
      isLoading(true);
      // var response = PaginationRepoImpl().getNextTransactions(
      //     userId, transactionType, DateTime.now(), [], lastFetchedSnapshot);
      // List<TransactionModel> tlist =
      //     response.then((value) => value!.docs.map((element) {
      //           return TransactionModel.fromJson(element.data());
      //         }).toList()) as List<TransactionModel>;
      // //paginatedList.value.addAll(tlist);
      // yield tlist;
    } catch (e) {
    } finally {
      isLoading(false);
    }
  }

  // void getFirst() async {
  //   String userId = PreferenceUtils.getString(user_id);
  //   print("Getting lists");
  //   var response = await PaginationRepoImpl()
  //       .getTransactions(userId, transactionType, DateTime.now(), []);
  //   List<TransactionModel> trxList = response!.docs.map((e) {
  //     lastFetchedSnapshot = e;
  //     return TransactionModel.fromJson(e.data());
  //   }).toList();
  //   paginatedList.value.addAll(trxList);
  //   paginatedList.value.forEach((element) {
  //     print("avinash cat name ${element.catName}");
  //   });
  // }

  // void getNext() async {
  //   String userId = PreferenceUtils.getString(user_id);
  //   print("Getting lists");
  //   var response = await PaginationRepoImpl().getNextTransactions(
  //       userId, transactionType, DateTime.now(), [], lastFetchedSnapshot);
  //   List<TransactionModel> trxList = response!.docs.map((e) {
  //     lastFetchedSnapshot = e;
  //     return TransactionModel.fromJson(e.data());
  //   }).toList();
  //   paginatedList.value.addAll(trxList);
  //   paginatedList.value.forEach((element) {
  //     print("avinash next cat name ${element.catName}");
  //   });
  // }

  /**
 * pagination testing
 */
  ScrollController _scrollController = ScrollController();
  void scrollLitener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      if (transactionList.length > 0) {
        transactionModel
            .bindStream(getNextTransactions("userId", "", DateTime.now(), [])!);
      } else {
        print("Reached end");
      }
    }
  }

  Stream<List<TransactionModel>>? getTransactions(
      String userId,
      String transactionType,
      DateTime currenctMonth,
      List<String> filterCategory) async* {
    try {
      initialLoad(true);
      var query = _firestore
          .collection(transaction)
          .where('user_id', isEqualTo: userId);
      if (transactionType != '' && transactionType.isNotEmpty) {
        //print(" type is available $transactionType");
        //query = query.where('transacion_type', isEqualTo: transactionType);
        //query = query.where('cat_name', isEqualTo: salary);
      }
      if (filterCategory.length > 0) {
        query = query.where('cat_name', whereIn: filterCategory);
      }
      yield* query
          .where('created_on',
              isGreaterThanOrEqualTo:
                  DateTime(currenctMonth.year, currenctMonth.month, 1)
                      .toIso8601String())
          .where('created_on',
              isLessThan:
                  DateTime(currenctMonth.year, currenctMonth.month + 1, 1)
                      .toIso8601String())
          .orderBy('created_on', descending: true)
          .limit(5)
          .snapshots()
          .map((query) {
        return query.docs.map((doc) {
          //lastFetchedSnapshot = doc;
          lastDoc = Rx<List<DocumentSnapshot>>([]);
          lastDoc.value..add(doc);
          TransactionModel tm = TransactionModel.fromJson(doc.data());
          print("hello everyone ${tm.catName}");
          return tm;
        }).toList();
      });
    } catch (e) {
      print(e.toString());
    } finally {
      initialLoad(false);
    }
  }

  Stream<List<TransactionModel>>? getNextTransactions(
      String userId,
      String transactionType,
      DateTime currenctMonth,
      List<String> filterCategory) async* {
    try {
      isFinished(false);

      var query = _firestore
          .collection(transaction)
          .where('user_id', isEqualTo: userId);
      if (transactionType != '' && transactionType.isNotEmpty) {
        //print(" type is available $transactionType");
        //query = query.where('transacion_type', isEqualTo: transactionType);
        //query = query.where('cat_name', isEqualTo: salary);
      }
      if (filterCategory.length > 0) {
        query = query.where('cat_name', whereIn: filterCategory);
      }

      query = query
          .where('created_on',
              isGreaterThanOrEqualTo:
                  DateTime(currenctMonth.year, currenctMonth.month, 1)
                      .toIso8601String())
          .where('created_on',
              isLessThan:
                  DateTime(currenctMonth.year, currenctMonth.month + 1, 1)
                      .toIso8601String())
          .orderBy('created_on', descending: true)
          .startAfterDocument(lastDoc.value.last)
          .limit(5);
      yield* query.snapshots().map((query) {
        (query.docs.length > 0) ? isFinished(false) : isFinished(true);
        return query.docs.map((doc) {
          lastDoc = Rx<List<DocumentSnapshot>>([]);
          lastDoc.value..add(doc);
          TransactionModel tm = TransactionModel.fromJson(doc.data());
          print("${lastDoc.value.length} hello everyone ${tm.catName}");
          return tm;
        }).toList();
      });
    } catch (e) {
      print(e.toString());
    } finally {
      isFinished(true);
    }
  }
}
