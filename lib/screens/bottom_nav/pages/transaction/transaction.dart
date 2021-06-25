import 'package:budgetplanner/screens/bottom_nav/pages/transaction/add_expense.dart';
import 'package:budgetplanner/screens/bottom_nav/pages/transaction/add_income.dart';
import 'package:budgetplanner/screens/bottom_nav/pages/transaction/add_saving.dart';
import 'package:budgetplanner/utils/string_constants.dart';
import 'package:budgetplanner/utils/styles.dart';
import 'package:budgetplanner/widgets/theme_constants.dart';
import 'package:flutter/material.dart';

class Transaction extends StatefulWidget {
  const Transaction({Key? key}) : super(key: key);

  @override
  _TransactionState createState() => _TransactionState();
}

class _TransactionState extends State<Transaction>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController _scrollViewController;
  List<String> name = ['Income', 'Expense', 'Savings'];
  @override
  void initState() {
    print("hey");
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
    _scrollViewController = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    _scrollViewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        physics: BouncingScrollPhysics(),
        controller: _scrollViewController,
        headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              centerTitle: true,
              title: Text(
                transactionEntry,
              ),
              floating: true,
              pinned: true,
              snap: true,
              bottom: TabBar(
                tabs: <Widget>[
                  for (final tabItem in name)
                    Tab(
                      child: Text(tabItem),
                    ),
                ],
                controller: _tabController,
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            AddIncome(),
            AddExpense(),
            AddSaving(),
          ],
        ),
      ),
    );
  }
}
