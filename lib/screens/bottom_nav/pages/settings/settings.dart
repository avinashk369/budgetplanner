import 'package:budgetplanner/screens/bottom_nav/pages/budget/budget_form.dart';
import 'package:budgetplanner/utils/string_constants.dart';
import 'package:budgetplanner/utils/styles.dart';
import 'package:budgetplanner/widgets/config.dart';
import 'package:budgetplanner/widgets/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

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
                          title: Text("Language"),
                          trailing:
                              Text(Get.locale!.languageCode.toUpperCase()),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Divider(
                            color: Theme.of(context).hintColor.withOpacity(.6),
                            height: 1,
                          ),
                        ),
                        ListTile(
                          title: Text("Theme"),
                          trailing: Text(
                              (currentTheme.currentTheme == ThemeMode.dark)
                                  ? "Dark"
                                  : "Light"),
                          onTap: () {
                            currentTheme.toggleTheme();
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Divider(
                            color: Theme.of(context).hintColor.withOpacity(.6),
                            height: 1,
                          ),
                        ),
                        ListTile(
                          title: Text("Currency"),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Divider(
                            color: Theme.of(context).hintColor.withOpacity(.6),
                            height: 1,
                          ),
                        ),
                        ListTile(
                          title: Text("Share"),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Divider(
                            color: Theme.of(context).hintColor.withOpacity(.6),
                            height: 1,
                          ),
                        ),
                        ListTile(
                          title: Text("Request feature"),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Divider(
                            color: Theme.of(context).hintColor.withOpacity(.6),
                            height: 1,
                          ),
                        ),
                        ListTile(
                          title: Text("Log out"),
                        ),
                      ],
                    )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
