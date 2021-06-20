abstract class DataRepository {
  void createBudgetCategory();
  void createIncomeCategory();
  void createTransactionType();
  void createExpenseType();
  void createSavingCategory();
  void createRecurrenceType();
  void clear(String collectionName);
}
