import 'package:budgetplanner/models/BaseModel.dart';
import 'package:budgetplanner/models/budget_category_model.dart';
import 'package:budgetplanner/models/budget_model.dart';
import 'package:budgetplanner/models/expense_source_model.dart';
import 'package:budgetplanner/models/income_model.dart';
import 'package:budgetplanner/models/promotion_model.dart';
import 'package:budgetplanner/models/recurrance_model.dart';
import 'package:budgetplanner/models/saving_category.dart';
import 'package:budgetplanner/models/transaction_model.dart';
import 'package:budgetplanner/models/transaction_type_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class DataRepository {
  Future createBudgetCategory();
  Future createIncomeCategory();
  Future createTransactionType();
  Future createExpenseType();
  Future createSavingCategory();
  Future createRecurrenceType();
  Future createExpenseSource();
  Future clear(String collectionName);
  Future<BaseModel<List<BudgetCategoryModel>>> getBudgetCategories();
  Future<BaseModel<List<IncomeModel>>> getIncomeCategories();
  Future<BaseModel<List<SavingCategory>>> getSavingCategories();
  Future<BaseModel<BudgetCategoryModel>> getBudgetCategory(String docId);
  Future<BaseModel<List<RecurranceModel>>> getRecurranceType();
  Future<BaseModel<List<TransactionType>>> getTransactionType();
  Future<BaseModel<List<ExpenseSourceModel>>> getExpenseSource();
  Stream<List<TransactionModel>>? getTransactions(
    String userId,
    String transactionType,
    DateTime currenctMonth,
    List<String> filterCategory,
    String expenseSource,
  );
  Stream<List<TransactionModel>>? getNextTransactions(
      String userId,
      String transactionType,
      DateTime currenctMonth,
      List<String> filterCategory,
      DocumentSnapshot lastDocument);
  Stream<List<TransactionModel>>? getRecentTransactions(String userId);
  Stream<List<BudgetModel>>? getBudgetList(String userId);
  Future saveTransaction(TransactionModel transactionModel);
  Future saveBudget(BudgetModel budgetModel);
  Stream<double> getTotalIncome(String monthName, String userId);
  Stream<double> getTotalExpense(String monthName, String userId);
  Future deleteTransaction(String id);
  Future<void> updateTransaction(TransactionModel transactionModel);
  Future deleteBudget(String id);
  Future<void> updateBudget(BudgetModel budgetModel);
  Future<BudgetModel?> getBudgetModel(String name, String userId);
  Future saveRequest(Map<String, dynamic> requestJson);
  Future generateCsv(List<List<String>> data);
  Stream<List<PromotionModel>> getAllPromotions();
}
