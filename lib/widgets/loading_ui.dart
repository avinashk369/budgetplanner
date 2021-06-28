import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class LoadingUI extends GetView {
  final bool text;

  LoadingUI({this.text = false});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircularProgressIndicator(
          color: Theme.of(context).hintColor,
          strokeWidth: 2,
        ),
        SizedBox(
          width: 15,
        ),
        (text) ? Text("Please wait...") : Container(),
      ],
    );
  }
}
