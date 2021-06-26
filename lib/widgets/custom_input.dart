import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final String? hintText;
  final Function(String? validation) validator;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  const CustomInput({
    Key? key,
    required this.validator,
    required this.hintText,
    required this.controller,
    this.textInputType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Theme.of(context).hintColor,
      keyboardType: textInputType ?? TextInputType.text,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: TextStyle(
        color: Theme.of(context).hintColor,
      ),
      decoration: InputDecoration(
        hintText: hintText,
      ),
    );
  }
}
