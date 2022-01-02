part of budget_entry;

class BudgetSlider extends GetView<BudgetController> {
  const BudgetSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var scrollController = ScrollController();
    scrollController.addListener(() {
      final extentAfter = scrollController.position.extentAfter;
    });

    return _slider(context);
  }

  Widget _rulerSlider(ScrollController scrollController) => RulerWidget(
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

  Widget _slider(BuildContext context) => Obx(
        () => SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: Colors.red[700],
            inactiveTrackColor: Colors.red[100],
            trackShape: RoundedRectSliderTrackShape(),
            trackHeight: 4.0,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
            thumbColor: Colors.redAccent,
            overlayColor: Colors.transparent,
            overlayShape: RoundSliderOverlayShape(overlayRadius: 12.0),
          ),
          child: Slider(
            value: controller.slidervalue.value,
            min: 0,
            max: controller.budgetDetail.value.catName != null
                ? controller.budgetDetail.value.amount! * 2
                : 1000,
            label: '${controller.slidervalue.value}',
            onChanged: (value) {
              controller.slidervalue.value = value;
              controller.isSliding(true);
              controller.message.value =
                  BudgetMessage.getBudgetMessage(controller.slidervalue.value);
            },
          ),
        ),
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
