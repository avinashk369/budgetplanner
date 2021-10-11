library budget_entry;

import 'package:budgetplanner/controllers/budget_controller.dart';
import 'package:budgetplanner/controllers/transaction_controller.dart';
import 'package:budgetplanner/models/budget_category_model.dart';
import 'package:budgetplanner/models/budget_model.dart';
import 'package:budgetplanner/resources/firestore/dataRepositoryImpl.dart';
import 'package:budgetplanner/utils/PreferenceUtils.dart';
import 'package:budgetplanner/utils/app_constants.dart';
import 'package:budgetplanner/utils/budget_messge.dart';
import 'package:budgetplanner/utils/controller_constants.dart';
import 'package:budgetplanner/utils/rulers/rulers.dart';
import 'package:budgetplanner/utils/string_constants.dart';
import 'package:budgetplanner/utils/styles.dart';
import 'package:budgetplanner/widgets/_ModalBottomSheetLayout.dart';
import 'package:budgetplanner/widgets/custom_input.dart';
import 'package:budgetplanner/widgets/custom_theme.dart';
import 'package:budgetplanner/widgets/loading_ui.dart';
import 'package:budgetplanner/widgets/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
part '../components/budget_input.dart';
part '../components/budget_bottom_action.dart';
part '../components/budget_cat_list.dart';
part '../components/budget_header.dart';
part '../components/build_budget_content.dart';
part '../components/build_budget_icon.dart';
part '../components/budget_slider.dart';

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
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Spacer(),
          Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BudgetHeader(
                transactionController: transactionController,
              ),
            ],
          ),
          Spacer(),
          Spacer(),
          Obx(
            () => transactionController.isLoading()
                ? LoadingUI()
                : BudgetCatList(
                    budgetList: transactionController.monthlyBudgetList,
                  ),
          ),
          Spacer(),
          Obx(
            () => transactionController.isLoading()
                ? LoadingUI()
                : BudgetBottom(),
          ),
        ],
      ),
    );
  }
}
