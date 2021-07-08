import 'package:budgetplanner/utils/PreferenceUtils.dart';
import 'package:budgetplanner/utils/app_constants.dart';
import 'package:budgetplanner/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:budgetplanner/widgets/theme_constants.dart';
import 'package:get/get.dart';

class CustomTheme with ChangeNotifier {
  static bool _isDarkTheme = PreferenceUtils.getBool(theme_mode);
  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    print("theme toggled");
    _isDarkTheme = !_isDarkTheme;
    PreferenceUtils.putBool(theme_mode, _isDarkTheme);
    notifyListeners();
  }

  static ThemeData get lightTheme {
    //1
    return ThemeData(
        //2
        primaryColor: whiteColor,
        scaffoldBackgroundColor: whiteColor,
        backgroundColor: whiteColor,
        accentColor: shade,
        tabBarTheme: TabBarTheme(
          unselectedLabelColor: kGrey,
          labelColor: shade,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: shade,
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: darkColor),
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: darkColor.withOpacity(.12))),
          errorBorder: OutlineInputBorder(borderSide: BorderSide(color: kred)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: darkColor)),
          focusedErrorBorder:
              OutlineInputBorder(borderSide: BorderSide(color: kred)),
          fillColor: Colors.transparent,
        ),
        hintColor: darkColor,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedLabelStyle: TextStyle(
            color: redColor,
            fontSize: 14,
          ),
          unselectedLabelStyle: TextStyle(
            color: kDarkGrey,
            fontSize: 12,
          ),
          backgroundColor: whiteColor,
          elevation: 0,
          selectedItemColor: shade,
          unselectedItemColor: kGrey,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          unselectedIconTheme: IconThemeData(
            color: kGrey,
            size: 20,
          ),
          selectedIconTheme: IconThemeData(
            color: orange,
            size: 22,
          ),
        ),
        brightness: Brightness.light,
        fontFamily: 'Montserrat',
        textTheme: TextTheme(
          headline1: kTitleStyle.copyWith(color: shade),
          headline2: kTitleStyleSmall.copyWith(color: shade),
          headline3: kQuoteStyle.copyWith(color: shade),
          caption: kLabelStyle.copyWith(color: shade),
          bodyText1: TextStyle(
            color: darkColor,
            fontSize: 18,
          ),
          subtitle1: TextStyle(
            color: darkColor,
            fontSize: 14,
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.0)),
          minimumSize: Size(Get.height * .2, Get.height * .07),
          //elevation: 1,
          textStyle: TextStyle(fontSize: 18),
          primary: darkColor,
          side: BorderSide(color: heenColor, width: 1),
        )),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0)),
            primary: bulbcolor,
          ),
        ),
        buttonTheme: ButtonThemeData(
          // 4
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
          buttonColor: kBlack,
        ));
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: darkColor,
      scaffoldBackgroundColor: darkColor,
      backgroundColor: darkColor,
      hintColor: whiteColor,
      accentColor: heenColor,
      tabBarTheme: TabBarTheme(
        unselectedLabelColor: kGrey,
        labelColor: heenColor,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: heenColor,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: whiteColor),
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: whiteColor.withOpacity(.12))),
        errorBorder: OutlineInputBorder(borderSide: BorderSide(color: kred)),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: whiteColor)),
        focusedErrorBorder:
            OutlineInputBorder(borderSide: BorderSide(color: kred)),
        fillColor: Colors.transparent,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedLabelStyle: TextStyle(
          color: whiteColor,
          fontSize: 14,
        ),
        unselectedLabelStyle: TextStyle(
          color: kGrey,
          fontSize: 12,
        ),
        backgroundColor: darkColor,
        elevation: 0,
        selectedItemColor: whiteColor,
        unselectedItemColor: kGrey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        unselectedIconTheme: IconThemeData(
          color: kGrey,
          size: 20,
        ),
        selectedIconTheme: IconThemeData(
          color: whiteColor,
          size: 22,
        ),
      ),
      brightness: Brightness.dark,
      fontFamily: 'Montserrat',
      textTheme: TextTheme(
        headline1: kTitleStyle,
        headline2: kTitleStyleSmall,
        headline3: kQuoteStyle,
        caption: kLabelStyle,
        bodyText1: TextStyle(
          color: whiteColor,
          fontSize: 18,
        ),
        subtitle1: TextStyle(
          color: whiteColor,
          fontSize: 14,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.0)),
        minimumSize: Size(Get.height * .2, Get.height * .07),
        //elevation: 1,
        textStyle: TextStyle(fontSize: 18),
        primary: whiteColor,
        side: BorderSide(color: heenColor, width: 1),
      )),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            textStyle: TextStyle(fontSize: 18),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3.0)),
            primary: heenColor,
            minimumSize: Size(Get.height * .2, Get.height * .07)),
      ),
      buttonTheme: ButtonThemeData(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        buttonColor: kBGreen,
      ),
    );
  }
}
