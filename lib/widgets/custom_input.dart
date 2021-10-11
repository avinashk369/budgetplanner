import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class CustomInput extends GetView {
  final String? hintText;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final bool isPassword;
  final bool isPrefix;
  final int? numOfLines;
  final Widget? prefixWidget;
  final FocusNode? focusNode;
  final String? initialValue;
  final Function(String value)? onchanged;
  const CustomInput({
    Key? key,
    this.validator,
    required this.hintText,
    this.controller,
    this.focusNode,
    this.textInputType,
    this.numOfLines,
    this.isPassword = false,
    this.initialValue,
    this.isPrefix = false,
    this.prefixWidget,
    this.onchanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      focusNode: focusNode,
      cursorColor: Theme.of(context).hintColor,
      keyboardType: textInputType ?? TextInputType.text,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      minLines: numOfLines,
      maxLines: numOfLines,
      obscureText: isPassword,
      onChanged: onchanged,
      style: TextStyle(
        color: Theme.of(context).hintColor,
        height: 1.4,
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(8),
        hintText: hintText,
        prefixIcon: isPrefix ? prefixWidget : null,
        prefixIconConstraints: BoxConstraints(
          minWidth: 30,
          minHeight: 48,
        ),
      ),
    );
  }
}
