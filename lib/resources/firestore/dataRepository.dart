import 'package:budgetplanner/models/BaseModel.dart';
import 'package:budgetplanner/models/budget_category_model.dart';
import 'package:budgetplanner/models/income_model.dart';
import 'package:budgetplanner/models/saving_category.dart';

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
}
