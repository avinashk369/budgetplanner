import 'package:budgetplanner/utils/PreferenceUtils.dart';
import 'package:budgetplanner/utils/app_constants.dart';
import 'package:budgetplanner/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:budgetplanner/widgets/theme_constants.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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
      appBarTheme: AppBarTheme(
        backgroundColor: whiteColor,
        centerTitle: true,
        elevation: 0,
        titleTextStyle: kLabelStyleBold.copyWith(fontSize: 18),
        foregroundColor: Colors.black,
      ),
      tabBarTheme: TabBarTheme(
        unselectedLabelColor: kGrey,
        labelColor: shade,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: shade, width: 2.0),
        ),
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
          color: darkColor,
          fontSize: 12,
        ),
        backgroundColor: whiteColor,
        elevation: 0,
        selectedItemColor: shade,
        unselectedItemColor: darkColor,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        unselectedIconTheme: IconThemeData(
          color: darkColor,
          size: 20,
        ),
        selectedIconTheme: IconThemeData(
          color: orange,
          size: 22,
        ),
      ),
      brightness: Brightness.light,
      fontFamily: GoogleFonts.lato().fontFamily!,
      textTheme: TextTheme(
        headlineSmall: kHeadlineSmall,
        headlineMedium: kHeadlineMedium,
        headlineLarge: kHeadlineLarge,
        bodySmall: kBodySmall,
        bodyLarge: kBodyLarge,
        bodyMedium: kBodyMedium,
        titleLarge: kTittleLarge,
        titleMedium: kTittleMedium,
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.0)),
        minimumSize: Size(Get.height * .2, Get.height * .07),
        //elevation: 1,
        textStyle: kLabelStyleBold.copyWith(fontSize: 18),
        primary: darkColor,
        side: BorderSide(color: heenColor, width: 1),
      )),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
          primary: bulbcolor,
        ),
      ),
      buttonTheme: ButtonThemeData(
        // 4
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        buttonColor: kBlack,
      ),
      colorScheme: ColorScheme.fromSwatch()
          .copyWith(secondary: shade, brightness: Brightness.light),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: darkColor,
      scaffoldBackgroundColor: darkColor,
      backgroundColor: darkColor,
      hintColor: whiteColor,
      appBarTheme: AppBarTheme(
        backgroundColor: darkColor,
        centerTitle: true,
        elevation: 0,
        titleTextStyle: kLabelStyleBold.copyWith(fontSize: 18),
        foregroundColor: Colors.white,
      ),
      tabBarTheme: TabBarTheme(
        unselectedLabelColor: kGrey,
        labelColor: heenColor,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: heenColor, width: 2.0),
        ),
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
      fontFamily: GoogleFonts.lato().fontFamily!,
      textTheme: TextTheme(
        headlineSmall: kHeadlineSmall,
        headlineMedium: kHeadlineMedium,
        headlineLarge: kHeadlineLarge,
        bodySmall: kLabelStyle,
        bodyLarge: TextStyle(
          color: whiteColor,
          fontSize: 18,
        ),
        titleMedium: TextStyle(
          color: whiteColor,
          fontSize: 14,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.0)),
        minimumSize: Size(Get.height * .2, Get.height * .07),
        //elevation: 1,
        textStyle: kLabelStyleBold.copyWith(fontSize: 18),
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
      colorScheme: ColorScheme.fromSwatch()
          .copyWith(secondary: heenColor, brightness: Brightness.dark),
    );
  }
}
