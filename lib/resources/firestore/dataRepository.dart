abstract class DataRepository {
  Future createBudgetCategory();
  Future createIncomeCategory();
  Future createTransactionType();
  Future createExpenseType();
  Future createSavingCategory();
  Future createRecurrenceType();
  Future createExpenseSource();
  Future clear(String collectionName);
}
