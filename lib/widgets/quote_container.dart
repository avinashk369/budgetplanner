import 'package:budgetplanner/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class QuoteContainer extends GetView {
  final String quote;
  final String author;
  const QuoteContainer(this.quote, this.author, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  quote,
                  style: Theme.of(context).textTheme.headline3,
                ),
                SizedBox(
                  height: 5,
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
                      style:
                          kLabelStyle.apply(color: Theme.of(context).hintColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
