import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:budgetplanner/screens/app_bar/custom_appbar.dart';
import 'package:budgetplanner/screens/bottom_nav/pages/poc/datamodel.dart';
import 'package:budgetplanner/widgets/theme_constants.dart';

class Demo extends StatefulWidget {
  final DataModel dataModel;

  const Demo({Key? key, required this.dataModel}) : super(key: key);
  @override
  _DemoState createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  void demo() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: CustomAppBar(
        "budgetplanner",
        testing: demo,
      ),
      body: Container(
        child: Column(
          children: [
            Text("Demo testing"),
          ],
        ),
      ),
    );
  }
}
