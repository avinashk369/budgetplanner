import 'package:budgetplanner/widgets/trx_shimmer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:budgetplanner/screens/app_bar/custom_appbar.dart';
import 'package:budgetplanner/screens/bottom_nav/pages/poc/datamodel.dart';
import 'package:budgetplanner/widgets/theme_constants.dart';
import 'package:shimmer/shimmer.dart';

class Demo extends StatefulWidget {
  final DataModel? dataModel;

  const Demo({Key? key, this.dataModel}) : super(key: key);
  @override
  _DemoState createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  bool _enabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Loading List'),
        ),
        body: Container(child: TrxShimmer()));
  }
}
