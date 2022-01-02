import 'package:budgetplanner/utils/string_constants.dart';
import 'package:budgetplanner/utils/styles.dart';
import 'package:budgetplanner/widgets/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Two extends StatelessWidget {
  Two();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyColor,
      body: Stack(
        children: <Widget>[
          // Adobe XD layer: 'photo-1566501206188…' (shape)
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .65,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage('assets/bl4.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                  color: tealColor.withOpacity(.12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        lbl_no_budget.tr,
                        textAlign: TextAlign.center,
                        style: kTitleStyle.copyWith(color: black, fontSize: 22),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        desc_no_budget.tr,
                        textAlign: TextAlign.center,
                        style: kLabelStyle.copyWith(
                            color: kDarkGrey, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          Visibility(
            visible: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.transparent, width: 0)),
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 100),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          width: 170.0,
                          height: 40.0,
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.transparent, width: 0),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              bottomLeft: Radius.circular(30.0),
                            ),
                            color: const Color(0xffffffff),
                          ),
                          child: Center(
                              child: Text(
                            'START TRAINING',
                            style: kLabelStyle,
                          )),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
