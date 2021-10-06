import 'package:budgetplanner/controllers/budget_controller.dart';
import 'package:budgetplanner/models/budget_category_model.dart';
import 'package:budgetplanner/models/budget_model.dart';
import 'package:budgetplanner/resources/firestore/dataRepositoryImpl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BudgetIcon extends GetView<BudgetController> {
  const BudgetIcon({
    Key? key,
    required this.move,
    required this.budgetCategoryModel,
    required this.budgetModel,
  }) : super(key: key);
  final BudgetCategoryModel budgetCategoryModel;
  final Function move;
  final BudgetModel budgetModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => move(),
      child: buildicon(budgetCategoryModel),
    );
  }

  Widget buildicon(BudgetCategoryModel budgetCategoryModel) => Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Colors.transparent,
      child: UnconstrainedBox(
        child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[200],
          ),
          child: Icon(
            DataRepositoryImpl().iconUrl(budgetCategoryModel.name!)!.iconName,
            color: DataRepositoryImpl()
                .iconUrl(budgetCategoryModel.name!)!
                .colorName,
          ),
        ),
      ));
}
