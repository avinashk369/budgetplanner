import 'package:budgetplanner/resources/firestore/dataRepositoryImpl.dart';
import 'package:budgetplanner/utils/PreferenceUtils.dart';
import 'package:budgetplanner/utils/app_constants.dart';
import 'package:budgetplanner/widgets/loading_dialog.dart';
import 'package:budgetplanner/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  static SettingsController get to => Get.find<SettingsController>();
  static SettingsController tagged(String name) =>
      Get.find<SettingsController>(tag: name);

  RxString langName = PreferenceUtils.getString(language, defValue: 'EN').obs;
  final GlobalKey<FormState> featureKey = GlobalKey<FormState>();
  final GlobalKey<State> keyLoader = new GlobalKey<State>();
  late TextEditingController notesController;
  var isLoading = true.obs;

  @override
  void onInit() {
    // TODO: implement onInit

    notesController = TextEditingController();

    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    notesController.dispose();
  }

  String? validateContents(String request) {
    if (request.length < 10) {
      return "Request content must be of 10 characters";
    }
    if (request.length > 100) {
      return "Request content must be of less than 100 characters";
    }
    return null;
  }

  void submitRequest(BuildContext context) async {
    final isValid = featureKey.currentState!.validate();
    if (!isValid) {
      return;
    }

    if (featureKey.currentState!.validate()) {
      try {
        isLoading(true);
        LoadingDialog.showLoadingDialog(context, keyLoader);
        Map<String, String> request = {
          "request": notesController.text,
          "user_id": PreferenceUtils.getString(user_id),
          "created_on": DateTime.now().toString()
        };

        await DataRepositoryImpl().saveRequest(request);
      } catch (e) {
        Navigator.of(keyLoader.currentContext!, rootNavigator: true).pop();
        SnackBarDialog.displaySnackbar(
          "Request",
          "Ooops!!!...request cancelled!",
        );
      } finally {
        isLoading(false);
        Navigator.of(keyLoader.currentContext!, rootNavigator: true).pop();
        SnackBarDialog.displaySuccessSnackbar(
          "Request",
          "Request submitted successfully!",
        );
      }
    }
  }
}
