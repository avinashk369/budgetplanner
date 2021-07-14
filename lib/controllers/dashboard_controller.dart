import 'package:budgetplanner/models/BaseModel.dart';
import 'package:budgetplanner/models/budget_category_model.dart';
import 'package:budgetplanner/resources/firestore/dataRepositoryImpl.dart';
import 'package:budgetplanner/utils/PreferenceUtils.dart';
import 'package:budgetplanner/utils/app_constants.dart';
import 'package:budgetplanner/widgets/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';

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

  Future getTransactions(BuildContext context) async {
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
