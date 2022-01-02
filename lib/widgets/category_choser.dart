import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryChooser extends GetView {
  final Widget leftRowData;
  final Widget rightRowData;
  const CategoryChooser({
    Key? key,
    required this.leftRowData,
    required this.rightRowData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: Get.width,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          border: Border.all(
              color: Theme.of(context).hintColor.withOpacity(.12), width: 1),
          borderRadius: BorderRadius.all(Radius.circular(4))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            flex: 2,
            child: leftRowData,
          ),
          Flexible(
            flex: 1,
            child: rightRowData,
          ),
        ],
      ),
    );
  }
}
