import 'package:budgetplanner/controllers/budget_controller.dart';
import 'package:budgetplanner/utils/rulers/rulers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BudgetSlider extends GetView<BudgetController> {
  const BudgetSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var scrollController = ScrollController();
    scrollController.addListener(() {
      final extentAfter = scrollController.position.extentAfter;

      print("Extent after: $extentAfter");
    });
    return RulerWidget(
      scaleSize: 100,
      scaleColor: Colors.grey[100],
      indicatorWidget: Column(
        children: <Widget>[
          Icon(
            Icons.arrow_drop_down,
            color: Colors.red,
            size: 30,
          ),
        ],
      ),
      limit: 30,
      interval: 3,
      normalBarColor: Colors.orange,
      inRangeBarColor: Colors.transparent,
      behindRangeBarColor: Colors.transparent,
      outRangeBarColor: Colors.transparent,
      scrollController: scrollController,
    );
  }

  Widget _slider() => Slider(
        value: controller.slidervalue.value,
        min: 0,
        max: 100,
        divisions: 10,
        label: '${controller.slidervalue.value}',
        onChanged: (value) {
          controller.slidervalue.value = value;
        },
      );

  // Widget _getLinearGauge() => Container(
  //       child: SfLinearGauge(
  //           minimum: 0.0,
  //           maximum: 100000000.0,
  //           showLabels: true,
  //           interval: 10,
  //           orientation: LinearGaugeOrientation.horizontal,
  //           majorTickStyle: LinearTickStyle(length: 20),
  //           axisLabelStyle: TextStyle(fontSize: 12.0, color: Colors.black),
  //           markerPointers: [
  //             LinearShapePointer(
  //                 value: controller.slidervalue.value,
  //                 onChanged: (value) {
  //                   controller.slidervalue.value = value;
  //                 },
  //                 color: Colors.blue[800]),
  //           ],
  //           axisTrackStyle: LinearAxisTrackStyle(
  //               color: Colors.cyan,
  //               edgeStyle: LinearEdgeStyle.bothFlat,
  //               thickness: 1.0,
  //               borderColor: Colors.grey)),
  //       margin: EdgeInsets.all(10),
  //     );
}
