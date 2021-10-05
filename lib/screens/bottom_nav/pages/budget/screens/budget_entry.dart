import 'package:budgetplanner/controllers/budget_controller.dart';
import 'package:budgetplanner/controllers/transaction_controller.dart';
import 'package:budgetplanner/screens/bottom_nav/pages/budget/components/budget_bottom_action.dart';
import 'package:budgetplanner/screens/bottom_nav/pages/budget/components/budget_cat_list.dart';
import 'package:budgetplanner/screens/bottom_nav/pages/budget/components/budget_header.dart';
import 'package:budgetplanner/utils/controller_constants.dart';
import 'package:budgetplanner/widgets/loading_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class BudgetEntry extends StatefulWidget {
  const BudgetEntry({Key? key}) : super(key: key);

  @override
  _BudgetEntryState createState() => _BudgetEntryState();
}

class _BudgetEntryState extends State<BudgetEntry> {
  final budget = BudgetController.tagged(budgetController);
  final transactionController = TransactionEntryController.to;
  @override
  void initState() {
    // TODO: implement initState
    transactionController.getMonthlyBudget();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BudgetHeader(
                          transactionController: transactionController,
                        ),
                      ],
                    ),
                    Obx(
                      () => transactionController.isLoading()
                          ? LoadingUI()
                          : BudgetCatList(
                              budget: budget,
                              budgetList:
                                  transactionController.monthlyBudgetList,
                            ),
                    ),
                    Obx(
                      () => transactionController.isLoading()
                          ? LoadingUI()
                          : BudgetBottom(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
