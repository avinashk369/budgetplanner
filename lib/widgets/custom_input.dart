import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class CustomInput extends GetView {
  final String? hintText;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final bool isPassword;
  const CustomInput({
    Key? key,
    required this.validator,
    required this.hintText,
    required this.controller,
    this.textInputType,
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
      obscureText: isPassword,
      style: TextStyle(
        color: Theme.of(context).hintColor,
      ),
      decoration: InputDecoration(
        hintText: hintText,
      ),
    );
  }
}
