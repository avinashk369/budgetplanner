import 'package:budgetplanner/models/BaseModel.dart';
import 'package:budgetplanner/models/budget_category_model.dart';
import 'package:budgetplanner/resources/firestore/dataRepositoryImpl.dart';
import 'package:budgetplanner/utils/PreferenceUtils.dart';
import 'package:budgetplanner/utils/app_constants.dart';
import 'package:budgetplanner/widgets/loading_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';
import 'package:permission_handler/permission_handler.dart';

class DashboardController extends GetxController {
  var currentIndex = 0.obs;
  setindex(int index) => currentIndex(index);
  var packageInfo = "".obs;
  var currencySymbol =
      PreferenceUtils.getString(currancy_symbol, defValue: '\u20B9').obs;
  setCurrency(String currencyName) => currencySymbol(currencyName);

  setPackgeInfo(String info) => packageInfo(info);
  static DashboardController tagged(String name) =>
      Get.find<DashboardController>(tag: name);

  final GlobalKey<State> keyLoader = new GlobalKey<State>();

  @override
  void onInit() {
    // TODO: implement onInit
    _initPackageInfo();
    super.onInit();
  }

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setPackgeInfo(info.version);
  }

  Future<bool> requestPersmission(BuildContext context) async {
    var status = await Permission.storage.status;
    if (status.isGranted) {
      return true;
    } else if (status.isDenied) {
      return false;
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) => CupertinoAlertDialog(
                title: Text('Storage Permission'),
                content: Text(
                    'This app needs storage access to download report files'),
                actions: <Widget>[
                  CupertinoDialogAction(
                    child: Text('Deny'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  CupertinoDialogAction(
                    child: Text('Settings'),
                    onPressed: () => openAppSettings(),
                  ),
                ],
              ));
    }
    return false;
  }

  Future<void> _checkPermission(BuildContext context) async {
    final serviceStatus = await Permission.storage.status;
    final isGpsOn = serviceStatus.isGranted;
    if (!isGpsOn) {
      print('Turn on location services before requesting permission.');
      return;
    }

    final status = await Permission.storage.request();
    if (status == PermissionStatus.granted) {
      print('Permission granted');
    } else if (status == PermissionStatus.denied) {
      print(
          'Permission denied. Show a dialog and again ask for the permission');
    } else if (status == PermissionStatus.permanentlyDenied) {
      print('Take the user to the settings page.');
      showDialog(
          context: context,
          builder: (BuildContext context) => CupertinoAlertDialog(
                title: Text('Storage Permission'),
                content: Text(
                    'This app needs storage access to download report files'),
                actions: <Widget>[
                  CupertinoDialogAction(
                    child: Text('Deny'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  CupertinoDialogAction(
                    child: Text('Settings'),
                    onPressed: () async => await openAppSettings(),
                  ),
                ],
              ));
    }
  }

  Future getTransactions(BuildContext context) async {
    _checkPermission(context);
    try {
      LoadingDialog.showLoadingDialog(context, keyLoader);
      BaseModel<List<BudgetCategoryModel>> listData =
          await DataRepositoryImpl().getBudgetCategories();
      List<List<String>> dataList = [];
      dataList.add(["No.", "Name", "ID"]);
      int i = 1;
      listData.data!.forEach((element) {
        dataList.add(["$i", "${element.name!}", "${element.id!}"]);
        i++;
      });

      await DataRepositoryImpl().generateCsv(dataList);
    } catch (e) {
      Navigator.of(keyLoader.currentContext!, rootNavigator: true).pop();
      print(e.toString());
    } finally {
      Navigator.of(keyLoader.currentContext!, rootNavigator: true).pop();
    }
  }
}
