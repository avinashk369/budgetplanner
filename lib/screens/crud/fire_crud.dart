import 'package:budgetplanner/models/BaseModel.dart';
import 'package:budgetplanner/models/CaffairModel.dart';
import 'package:budgetplanner/resources/firestore/dataRepositoryImpl.dart';
import 'package:budgetplanner/resources/firestore/userRepositoryImpl.dart';
import 'package:budgetplanner/utils/category_constants.dart';
import 'package:budgetplanner/widgets/theme_constants.dart';
import 'package:flutter/material.dart';

class FireCrud extends StatefulWidget {
  const FireCrud({Key? key}) : super(key: key);

  @override
  _FireCrudState createState() => _FireCrudState();
}

class _FireCrudState extends State<FireCrud> {
  List<String> actions = ['create', 'update', 'read', 'delete'];
  UserRepositoryImpl userRepositoryImpl = UserRepositoryImpl();
  DataRepositoryImpl dataRepositoryImpl = DataRepositoryImpl();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: GridView.builder(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemCount: actions.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.all(5),
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: kDarkGrey,
              ),
              child: Center(
                child: ElevatedButton(
                  child: Icon(dataRepositoryImpl.iconUrl(travel)!.iconName),
                  onPressed: () {
                    action(actions[index]);
                  },
                ),
              ),
            );
          }),
    );
  }

  void action(String name) async {
    switch (name) {
      case "create":
        await dataRepositoryImpl.createBudgetCategory();
        await dataRepositoryImpl.createExpenseType();
        await dataRepositoryImpl.createIncomeCategory();
        await dataRepositoryImpl.createRecurrenceType();
        await dataRepositoryImpl.createSavingCategory();
        await dataRepositoryImpl.createTransactionType();
        await dataRepositoryImpl.createExpenseSource();
        break;
      case "read":
        BaseModel<CaffairModel> records =
            await userRepositoryImpl.readCollections();
        //print(records.data!.title);
        break;
      case "update":
        dataRepositoryImpl.iconUrl('health');
        break;
      case "delete":
        await dataRepositoryImpl.clear(budgetCategory);
        await dataRepositoryImpl.clear(incomeCategory);
        await dataRepositoryImpl.clear(expenseType);
        await dataRepositoryImpl.clear(recurranceCategory);
        await dataRepositoryImpl.clear(transactionType);
        await dataRepositoryImpl.clear(savingCategory);
        await dataRepositoryImpl.clear(expenseSource);
        break;
    }
  }
}
