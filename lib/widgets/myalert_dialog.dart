import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAlertDialog extends GetView {
  final Widget title;
  final Widget content;
  final List<Widget>? actions;

  MyAlertDialog({required this.title, required this.content, this.actions});

  @override
  Widget build(BuildContext context) {
    return GetPlatform.isAndroid
        ? AlertDialog(
            title: title,
            content: content,
            actions: actions,
          )
        : CupertinoAlertDialog(
            title: title,
            content: content,
            actions: actions ?? [],
          );
  }
}
