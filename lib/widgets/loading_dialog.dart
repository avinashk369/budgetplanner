import 'package:budgetplanner/utils/styles.dart';
import 'package:budgetplanner/widgets/theme_constants.dart';
import 'package:flutter/material.dart';

class LoadingDialog {
  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return new WillPopScope(
                  onWillPop: () async => false,
                  child: Material(
                    key: key,
                    color: Colors.transparent,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                  ));
            },
          );
        });
  }

  static Future<void> showLoadingDialog1(
      BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  key: key,
                  backgroundColor: kWhite,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Please Wait....",
                          style: kLabelStyle,
                        )
                      ]),
                    )
                  ]));
        });
  }
}
