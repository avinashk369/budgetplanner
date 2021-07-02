import 'dart:io';

import 'package:budgetplanner/screens/bottom_nav/pages/settings/feature_request.dart';
import 'package:budgetplanner/screens/bottom_nav/pages/settings/language_screen.dart';
import 'package:budgetplanner/utils/PreferenceUtils.dart';
import 'package:budgetplanner/utils/app_constants.dart';
import 'package:budgetplanner/utils/styles.dart';
import 'package:budgetplanner/widgets/config.dart';
import 'package:budgetplanner/widgets/theme_constants.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
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
                            "Customise your app",
                            style: kLabelStyle.apply(
                                color: Theme.of(context).hintColor),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Settings",
                            style: kTitleStyle,
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
                            title: Text(
                              "Language",
                            ),
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
                            title: Text(
                              "Theme",
                            ),
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
                                  )
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
                            title: Text(
                              "Currency",
                            ),
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
                                  setState(() {});
                                  print('Select currency: ${currency.flag}');
                                },
                              );
                            },
                            trailing: Text(PreferenceUtils.getString(
                                currancy_symbol,
                                defValue: '\u20B9')),
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
                              "Share",
                            ),
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
                            title: Text(
                              "Request feature",
                            ),
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
                              style: kLabelStyle.apply(color: redColor),
                            ),
                          ),
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
          child: Text(
            "App version 0.0.1",
            style: kLabelStyle,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  _onShareWithEmptyOrigin(BuildContext context, String url) async {
    await Share.share(url);
  }
}
