import 'package:budgetplanner/ad/banner_ad.dart';
import 'package:budgetplanner/controllers/ad_controller.dart';
import 'package:budgetplanner/screens/bottom_nav/pages/settings/language_data.dart';
import 'package:budgetplanner/utils/PreferenceUtils.dart';
import 'package:budgetplanner/utils/app_constants.dart';
import 'package:budgetplanner/utils/controller_constants.dart';
import 'package:budgetplanner/utils/styles.dart';
import 'package:budgetplanner/widgets/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  @override
  Widget build(BuildContext context) {
    final adCont = AdController.tagged(adController);

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
                            "Configure your regional",
                            style: kLabelStyle.apply(
                                color: Theme.of(context).hintColor),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Language",
                            style: kTitleStyle,
                          )
                        ],
                      ),
                    ),
                    //BudgetCard()
                  ],
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Container(
                        child: Column(
                      children: [
                        ListView.separated(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: LanguageData.getLanguageList().length,
                            separatorBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Divider(
                                    color: Theme.of(context)
                                        .hintColor
                                        .withOpacity(.6),
                                    height: 1,
                                  ),
                                ),
                            itemBuilder: (BuildContext context, int position) {
                              return ListTile(
                                title: Text(
                                    LanguageData.getLanguageList()[position]
                                        .name),
                                subtitle: Text(
                                    LanguageData.getLanguageList()[position]
                                        .code),
                                trailing: FittedBox(
                                  fit: BoxFit.fill,
                                  child: Row(
                                    children: [
                                      Text(LanguageData.getLanguageList()[
                                              position]
                                          .initial)
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  PreferenceUtils.putString(
                                      language,
                                      LanguageData.getLanguageList()[position]
                                          .initial);
                                  PreferenceUtils.putString(
                                      locale,
                                      LanguageData.getLanguageList()[position]
                                          .code);
                                  Get.updateLocale(
                                      LanguageData.getLanguageList()[position]
                                          .locale);
                                  setState(() {});
                                },
                                selected:
                                    (LanguageData.getLanguageList()[position]
                                                .code ==
                                            PreferenceUtils.getString(locale,
                                                defValue: 'EN'))
                                        ? true
                                        : false,
                              );
                            })
                      ],
                    )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BannerAdView(),
    );
  }
}
