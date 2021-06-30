import 'package:budgetplanner/utils/styles.dart';
import 'package:budgetplanner/widgets/theme_constants.dart';
import 'package:flutter/material.dart';

class NoData extends StatelessWidget {
  final String message;

  const NoData({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Icon(Icons.ac_unit),
            SizedBox(
              height: 10,
            ),
            Text(
              message,
              style: kQuoteStyle.apply(color: kPink),
            ),
          ],
        ),
      ),
    );
  }
}
