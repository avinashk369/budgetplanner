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
  final Function goTo;

  const NoData(
      {Key? key,
      required this.title,
      required this.message,
      required this.imageUrl,
      required this.index,
      required this.goTo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dashController = DashboardController.tagged(dashboardController);
    return InkWell(
      onTap: () => goTo(), //dashController.setindex(index),
      child: Row(
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
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: heenColor,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  message,
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).hintColor.withOpacity(.6),
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 10,
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    minimumSize: Size(40, 40),
                    backgroundColor: whiteColor,
                    side: BorderSide(
                      color: heenColor,
                      width: 1,
                    ),
                  ),
                  onPressed: () {
                    //dashController.setindex(index);
                    goTo();
                  },
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Theme.of(context).hintColor.withOpacity(.8),
                    size: 20,
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
      ),
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
