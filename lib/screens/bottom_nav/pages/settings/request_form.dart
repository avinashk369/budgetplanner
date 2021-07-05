import 'package:budgetplanner/controllers/settings_controller.dart';
import 'package:budgetplanner/utils/string_constants.dart';
import 'package:budgetplanner/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestForm extends StatelessWidget {
  final SettingsController controller;
  const RequestForm({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomInput(
          controller: controller.notesController,
          hintText: feature_request.tr,
          numOfLines: 3,
          validator: (value) => controller.validateContents(value!),
          textInputType: TextInputType.text,
        ),
      ],
    );
  }
}
