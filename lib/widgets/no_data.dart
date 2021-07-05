import 'package:budgetplanner/controllers/dashboard_controller.dart';
import 'package:budgetplanner/utils/controller_constants.dart';
import 'package:budgetplanner/utils/styles.dart';
import 'package:budgetplanner/widgets/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoData extends StatelessWidget {
  final String title;
  final String message;
  final String imageUrl;
  final int index;

  const NoData(
      {Key? key,
      required this.title,
      required this.message,
      required this.imageUrl,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dashController = DashboardController.tagged(dashboardController);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Image.asset(
            imageUrl,
          ),
        ),
        Flexible(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: heenColor,
                    fontSize: 16,
                    fontStyle: FontStyle.italic),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                message,
                textAlign: TextAlign.left,
                style: kLabelStyle.copyWith(
                  color: Theme.of(context).hintColor,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  minimumSize: Size(50, 50),
                  primary: whiteColor,
                  side: BorderSide(
                    color: heenColor,
                    width: 1,
                  ),
                ),
                onPressed: () {
                  dashController.setindex(index);
                },
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Theme.of(context).hintColor,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // Text(
              //   lbl_add_one.tr,
              //   style: kLabelStyleBold,
              // ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget row() {
  return Row(
    children: [
      Container(
        height: Get.height * .27,
        width: Get.height * .27,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            bottomLeft: Radius.circular(8),
          ),
        ),
        child: Image.asset(
          'assets/budget.jpeg',
        ),
      )
    ],
  );
}
