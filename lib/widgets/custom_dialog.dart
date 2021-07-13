import 'package:budgetplanner/utils/styles.dart';
import 'package:budgetplanner/widgets/theme_constants.dart';
import 'package:flutter/material.dart';

class CustomDialog {
  static deleteDiaolg(
      {required Function yes,
      required Function no,
      required String yesButtonLabel,
      required String noButtonLabel,
      required String message}) {
    return AlertDialog(
      backgroundColor: whiteColor,
      content: Text(message,
          style: kHeaderStyle.copyWith(
            color: darkColor,
          )),
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButton(
                style: OutlinedButton.styleFrom(minimumSize: Size(100, 40)),
                child: Text(noButtonLabel,
                    style: kLabelStyle.copyWith(color: darkColor)),
                onPressed: () => no(),
              ),
              OutlinedButton(
                child: Text(
                  yesButtonLabel,
                  style: kLabelStyle.copyWith(color: darkColor),
                ),
                style: OutlinedButton.styleFrom(minimumSize: Size(100, 40)),
                onPressed: () => yes(),
              ),
            ],
          ),
        )
      ],
    );
  }

  static exitDialog(
      {required Function yes,
      required Function no,
      required String yesButtonLabel,
      required String noButtonLabel,
      required String message}) {
    return AlertDialog(
      backgroundColor: whiteColor,
      content: Text(message,
          style: kHeaderStyle.copyWith(
            color: darkColor,
          )),
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButton(
                style: OutlinedButton.styleFrom(minimumSize: Size(100, 40)),
                child: Text(noButtonLabel),
                onPressed: () => no(),
              ),
              OutlinedButton(
                child: Text(yesButtonLabel),
                style: OutlinedButton.styleFrom(minimumSize: Size(100, 40)),
                onPressed: () => yes(),
              ),
            ],
          ),
        )
      ],
    );
  }
}
