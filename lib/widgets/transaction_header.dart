import 'package:budgetplanner/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'theme_constants.dart';

class TransactionHeader extends StatelessWidget {
  final String imageUrl;

  const TransactionHeader({Key? key, required this.imageUrl}) : super(key: key);
  final String quote =
      "\"I will tell you how to become rich. Close the doors. Be fearful when others are greedy. Be greedy when others are fearful.\"";
  final String author = "Warren Buffett";
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 10),
          height: Get.height * .25,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: whiteColor,
            image: DecorationImage(
              fit: BoxFit.cover,
              // colorFilter: ColorFilter.mode(
              //     darkColor.withOpacity(0.4), BlendMode.dstATop),
              image: NetworkImage(
                imageUrl,
              ),
            ),
          ),
        ),
        Container(
          height: Get.height * .25,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                kDarkGrey,
                darkColor.withOpacity(.5),
              ],
            ),
          ),
        ),
        Container(
          height: Get.height * .25,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  quote,
                  style: kQuoteStyle,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: 3),
                      child: Container(
                        width: 30,
                        height: 2,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.red, width: 3),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(1.5),
                              bottomRight: Radius.circular(1.5),
                            ),
                            color: Colors.red),
                      ),
                    ),
                    Text(
                      author,
                      textAlign: TextAlign.end,
                      style: kLabelStyle.apply(color: whiteColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
