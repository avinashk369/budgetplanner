import 'package:budgetplanner/utils/app_constants.dart';
import 'package:budgetplanner/utils/styles.dart';
import 'package:budgetplanner/widgets/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

const String _svg_j6doiw =
    '<svg viewBox="0.5 289.5 50.0 110.0" ><path transform="translate(0.5, 289.5)" d="M 0 0 L 50 0" fill="#242323" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(0.5, 399.5)" d="M 0 0 L 45 0" fill="none" stroke="#242323" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';

class One extends StatelessWidget {
  One();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyColor,
      body: Stack(
        children: <Widget>[
          // Adobe XD layer: 'photo-1566501206188…' (shape)
          Container(
            width: double.infinity,
            //decoration: BoxDecoration(border: Border.all(color: red)),
            padding: const EdgeInsets.all(40.0),
            child: Image.asset(
              'assets/logo1.png',
              height: 160,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      'BE \nFINANCIALLY',
                      style: kTitleStyle.apply(color: kDarkGrey),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      'DISCIPLINE',
                      style: kTitleStyle.apply(
                        color: shade,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: Container(
                            width: 50,
                            height: 3,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.red, width: 3),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(1.5),
                                  bottomRight: Radius.circular(1.5),
                                ),
                                color: Colors.red),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            'Your personal expense management tool',
                            style: kLabelStyle.apply(
                                fontSizeDelta: 3, color: kDarkGrey),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
          Column(
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
                        width: 150.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.transparent, width: 0),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            bottomLeft: Radius.circular(30.0),
                          ),
                          color: kWhite,
                        ),
                        child: Center(
                            child: Text(
                          appname,
                          style: kLabelStyleBold.copyWith(fontSize: 18),
                        )),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
