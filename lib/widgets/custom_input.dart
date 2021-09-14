import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class CustomInput extends GetView {
  final String? hintText;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final bool isPassword;
  final int? numOfLines;
  const CustomInput({
    Key? key,
    this.validator,
    required this.hintText,
    required this.controller,
    this.textInputType,
    this.numOfLines,
    this.isPassword = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: Theme.of(context).hintColor,
      keyboardType: textInputType ?? TextInputType.text,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      minLines: numOfLines,
      maxLines: numOfLines,
      obscureText: isPassword,
      style: TextStyle(
        color: Theme.of(context).hintColor,
        height: 1.4,
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(8),
        hintText: hintText,
      ),
    );
  }
}
