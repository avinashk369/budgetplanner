import 'package:budgetplanner/controllers/expense_controller.dart';
import 'package:budgetplanner/controllers/income_controller.dart';
import 'package:budgetplanner/controllers/transaction_controller.dart';
import 'package:budgetplanner/models/budget_category_model.dart';
import 'package:budgetplanner/models/expense_source_model.dart';
import 'package:budgetplanner/models/income_model.dart';
import 'package:budgetplanner/models/recurrance_model.dart';
import 'package:budgetplanner/models/transaction_model.dart';
import 'package:budgetplanner/screens/bottom_nav/pages/transaction/expense_form.dart';
import 'package:budgetplanner/screens/bottom_nav/pages/transaction/income_form.dart';
import 'package:budgetplanner/utils/category_constants.dart';
import 'package:budgetplanner/utils/controller_constants.dart';
import 'package:budgetplanner/utils/styles.dart';
import 'package:budgetplanner/widgets/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateTransaction extends StatelessWidget {
  final TransactionModel transactionModel;
  const UpdateTransaction({Key? key, required this.transactionModel})
      : super(key: key);
  initExpenseForm(ExpenseController expenseController) {
    ExpenseSourceModel expenseSourceModel = ExpenseSourceModel();
    RecurranceModel recurranceModel = RecurranceModel();
    BudgetCategoryModel budgetCategoryModel = BudgetCategoryModel();
    budgetCategoryModel.name = transactionModel.catName;
    expenseSourceModel.name = transactionModel.expenseSource;
    recurranceModel.name = transactionModel.recurrance;
    expenseController.setExpenseMode(budgetCategoryModel);
    expenseController.setExpenseSource(expenseSourceModel);
    expenseController.setRecurranceModeel(recurranceModel);
    expenseController.notesController.text = transactionModel.notes!;
    expenseController.amountController.text =
        transactionModel.amount.toString();
  }

  iniIncome(IncomeController incomeController) {
    ExpenseSourceModel expenseSourceModel = ExpenseSourceModel();
    RecurranceModel recurranceModel = RecurranceModel();
    IncomeModel incomeModel = IncomeModel();
    incomeModel.name = transactionModel.catName;
    expenseSourceModel.name = transactionModel.expenseSource;
    recurranceModel.name = transactionModel.recurrance;
    incomeController.setIncomeMode(incomeModel);

    incomeController.setRecurranceModeel(recurranceModel);
    incomeController.notesController.text = transactionModel.notes!;
    incomeController.amountController.text = transactionModel.amount.toString();
  }

  @override
  Widget build(BuildContext context) {
    final controller = TransactionEntryController.to;
    final incomeC = Get.find<IncomeController>(tag: incomeController);

    //final expenseC = Get.put(ExpenseController(), tag: expenseController);
    final expenseC = Get.find<ExpenseController>(tag: expenseController);

    (transactionModel.transactionType == expense)
        ? initExpenseForm(expenseC)
        : iniIncome(incomeC);

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(elevation: 0),
      body: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: kSpaceS, vertical: kSpaceM),
          child: CustomScrollView(
            //controller: ScrollController(),
            physics: BouncingScrollPhysics(),
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 8),
                      height: Get.height * .15,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Update your daily",
                            style: kLabelStyle.apply(
                                color: Theme.of(context).hintColor),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            transactionModel.transactionType!,
                            style: kTitleStyle,
                          )
                        ],
                      ),
                    ),
                    //BudgetCard()
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 10,
                ),
              ),
              SliverToBoxAdapter(
                child: Form(
                  //key: controller.,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      (transactionModel.transactionType == expense)
                          ? ExpenseForm(controller: expenseC)
                          : IncomeForm(controller: incomeC),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              controller
                                  .deletetransaction(transactionModel.id!);
                              print(transactionModel.catName);
                            },
                            child: Text("Delete"),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              transactionModel.amount = 299;
                              transactionModel.updatedOn = DateTime.now();
                              controller.updatetransaction(transactionModel);
                            },
                            child: Text("Update"),
                          ),
                        ],
                      )),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
