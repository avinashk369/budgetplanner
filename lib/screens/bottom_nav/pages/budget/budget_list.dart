import 'package:budgetplanner/models/budget_model.dart';
import 'package:budgetplanner/screens/bottom_nav/pages/budget/budget_card.dart';
import 'package:flutter/material.dart';

class BudgetList extends StatefulWidget {
  final List<BudgetModel>? budgetModel;
  BudgetList({this.budgetModel});
  @override
  _BudgetListState createState() => _BudgetListState();
}

class _BudgetListState extends State<BudgetList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (BuildContext context, int position) {
          //BudgetModel budget = widget.budgetModel![position];
          return Padding(padding: EdgeInsets.all(5), child: BudgetCard());
        });
  }
}
