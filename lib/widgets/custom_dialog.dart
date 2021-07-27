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

  static customExitDialog(
      {required Function yes,
      required Function no,
      required String yesButtonLabel,
      required String noButtonLabel,
      required String message}) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Container(
        height: 220,
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: Colors.white70,
                child: Icon(
                  Icons.exit_to_app,
                  size: 60,
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(4),
                      bottomRight: Radius.circular(4)),
                  color: Colors.redAccent,
                ),
                child: SizedBox.expand(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          message,
                          style: kLabelStyle.copyWith(
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  minimumSize: Size(100, 40),
                                  side: BorderSide(
                                    color: whiteColor,
                                  ),
                                ),
                                child: Text(
                                  noButtonLabel,
                                  style:
                                      kLabelStyle.copyWith(color: whiteColor),
                                ),
                                onPressed: () => no(),
                              ),
                              OutlinedButton(
                                child: Text(
                                  yesButtonLabel,
                                  style:
                                      kLabelStyle.copyWith(color: whiteColor),
                                ),
                                style: OutlinedButton.styleFrom(
                                  minimumSize: Size(100, 40),
                                  side: BorderSide(
                                    color: whiteColor,
                                  ),
                                ),
                                onPressed: () => yes(),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
