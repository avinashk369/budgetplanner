import 'package:budgetplanner/models/BaseModel.dart';
import 'package:budgetplanner/models/budget_category_model.dart';

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
  Future<BaseModel<BudgetCategoryModel>> getBudgetCategory(String docId);
}
