import 'dart:convert';
import 'dart:io';

import 'package:budgetplanner/controllers/dashboard_controller.dart';
import 'package:budgetplanner/screens/bottom_nav/pages/settings/feature_request.dart';
import 'package:budgetplanner/screens/bottom_nav/pages/settings/language_screen.dart';
import 'package:budgetplanner/utils/PreferenceUtils.dart';
import 'package:budgetplanner/utils/app_constants.dart';
import 'package:budgetplanner/utils/authentication.dart';
import 'package:budgetplanner/utils/controller_constants.dart';
import 'package:budgetplanner/utils/notification_service.dart';
import 'package:budgetplanner/utils/route_constants.dart';
import 'package:budgetplanner/utils/string_constants.dart';
import 'package:budgetplanner/utils/styles.dart';
import 'package:budgetplanner/widgets/config.dart';
import 'package:budgetplanner/widgets/theme_constants.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:share/share.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final controller = DashboardController.tagged(dashboardController);

  @override
  void initState() {
    super.initState();

    NotificationService().init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0),
      body: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: kSpaceS, vertical: kSpaceM),
          child: CustomScrollView(
            //controller: ScrollController(),
            physics: BouncingScrollPhysics(),
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 8),
                      height: Get.height * .15,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            lbl_settings_cutomise.tr,
                            style: kLabelStyle.apply(
                                color: Theme.of(context).hintColor),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            settingsTab.tr,
                            style: Theme.of(context).textTheme.headline1,
                          )
                        ],
                      ),
                    ),
                    //BudgetCard()
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 10,
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Container(
                      child: Column(
                        children: [
                          ListTile(
                            title: Text("Language",
                                style: kLabelStyle.copyWith(
                                    color: Theme.of(context).hintColor)),
                            trailing: Text(PreferenceUtils.getString(language,
                                defValue: 'EN')),
                            onTap: () {
                              Get.to(LanguageScreen());
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Divider(
                              color:
                                  Theme.of(context).hintColor.withOpacity(.6),
                              height: 1,
                            ),
                          ),
                          ListTile(
                            title: Text("Theme",
                                style: kLabelStyle.copyWith(
                                    color: Theme.of(context).hintColor)),
                            trailing: FittedBox(
                              fit: BoxFit.fill,
                              child: Row(
                                children: [
                                  Icon((currentTheme.currentTheme ==
                                          ThemeMode.dark)
                                      ? Icons.dark_mode
                                      : Icons.light_mode),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                      (PreferenceUtils.getBool(theme_mode))
                                          ? "Dark"
                                          : "Light",
                                      style: kLabelStyle.copyWith(
                                          color: Theme.of(context).hintColor))
                                ],
                              ),
                            ),
                            onTap: () {
                              currentTheme.toggleTheme();
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Divider(
                              color:
                                  Theme.of(context).hintColor.withOpacity(.6),
                              height: 1,
                            ),
                          ),
                          ListTile(
                            title: Text("Currency",
                                style: kLabelStyle.copyWith(
                                    color: Theme.of(context).hintColor)),
                            onTap: () {
                              showCurrencyPicker(
                                context: context,
                                showFlag: true,
                                showCurrencyName: true,
                                showCurrencyCode: true,
                                onSelect: (Currency currency) {
                                  PreferenceUtils.putString(
                                      currancy_symbol, currency.symbol);
                                  PreferenceUtils.putString(
                                      currency_name, currency.flag);
                                  controller.setCurrency(currency.symbol);
                                  setState(() {});
                                  print('Select currency: ${currency.symbol}');
                                },
                              );
                            },
                            trailing: Text(
                              PreferenceUtils.getString(currancy_symbol,
                                  defValue: '\u20B9'),
                              style: kHeaderStyle.copyWith(
                                  color: Theme.of(context).hintColor),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Divider(
                              color:
                                  Theme.of(context).hintColor.withOpacity(.6),
                              height: 1,
                            ),
                          ),
                          ListTile(
                            title: Text("Share",
                                style: kLabelStyle.copyWith(
                                    color: Theme.of(context).hintColor)),
                            onTap: () async {
                              if (Platform.isAndroid) {
                                print('Android');
                                _onShareWithEmptyOrigin(
                                    context, play_store_url);
                                // Android 9 (SDK 28), Xiaomi Redmi Note 7
                              }

                              if (Platform.isIOS) {
                                _onShareWithEmptyOrigin(context, app_store_url);
                                print('ios');
                                // iOS 13.1, iPhone 11 Pro Max iPhone
                              }
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Divider(
                              color:
                                  Theme.of(context).hintColor.withOpacity(.6),
                              height: 1,
                            ),
                          ),
                          ListTile(
                            title: Text("Request feature",
                                style: kLabelStyle.copyWith(
                                    color: Theme.of(context).hintColor)),
                            onTap: () => Get.to(FeatureRequestScreen()),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Divider(
                              color:
                                  Theme.of(context).hintColor.withOpacity(.6),
                              height: 1,
                            ),
                          ),
                          ListTile(
                            title: Text(
                              "Log out",
                              style: kLabelStyle.apply(color: shade),
                            ),
                            onTap: () async {
                              await Authentication.signOut(context: context);
                              PreferenceUtils.clear();
                              Navigator.of(context).popAndPushNamed(homeRoute);
                              controller.setCurrency("\u20B9");
                              controller.setindex(0);
                            },
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(horizontal: 10),
                          //   child: Divider(
                          //     color:
                          //         Theme.of(context).hintColor.withOpacity(.6),
                          //     height: 1,
                          //   ),
                          // ),
                          // ListTile(
                          //   title: Text("Download", style: kLabelStyle),
                          //   onTap: () async {
                          //     Map<String, dynamic> result = {
                          //       'isSuccess': false,
                          //       'filePath': "abcd",
                          //       'error': "sorry ",
                          //     };
                          //show report chart
                          //Get.to(BarChartSample5());
                          // await NotificationService()
                          //     .scheduleDailyTenAMNotification();
                          // await NotificationService()
                          //     .showNotification(result);
                          // await NotificationService()
                          //     .periodicNotification(result);
                          // await NotificationService().zonedSchedule(result,
                          //     androidAllowWhileIdle: true,
                          //     uiLocalNotificationDateInterpretation:
                          //         UILocalNotificationDateInterpretation
                          //             .absoluteTime);
                          // await NotificationService().cancelNotification();
                          //download csv
                          //await controller.getTransactions(context);
                          //startService();
                          //   },
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(
            () => Text(
              "App version " + controller.packageInfo.value,
              style: kLabelStyle.copyWith(
                  color: Theme.of(context).hintColor.withOpacity(.4)),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  _onShareWithEmptyOrigin(BuildContext context, String url) async {
    await Share.share(url);
  }

  Future<void> startService() async {
    try {
      print("Strting service");
      if (Platform.isAndroid) {
        var methodChannel = MethodChannel("com.finance.budgetplanner");
        String data = await methodChannel.invokeMethod("startService");
        debugPrint(data);
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
