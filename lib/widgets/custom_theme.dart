import 'package:flutter/material.dart';
import 'package:budgetplanner/widgets/theme_constants.dart';

class CustomTheme with ChangeNotifier {
  static bool _isDarkTheme = true;
  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    print("theme toggled");
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  static ThemeData get lightTheme {
    //1
    return ThemeData(
        //2
        primaryColor: whiteColor,
        scaffoldBackgroundColor: whiteColor,
        backgroundColor: whiteColor,
        accentColor: redColor,
        tabBarTheme: TabBarTheme(
          unselectedLabelColor: kGrey,
          labelColor: redColor,
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
          selectedItemColor: redColor,
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
          headline1: TextStyle(
            color: darkColor,
            fontSize: 16,
          ),
          bodyText1: TextStyle(
            color: darkColor,
            fontSize: 18,
          ),
          subtitle1: TextStyle(
            color: darkColor,
            fontSize: 14,
          ),
        ),
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
          headline1: TextStyle(
            color: whiteColor,
            fontSize: 16,
          ),
          bodyText1: TextStyle(
            color: whiteColor,
            fontSize: 18,
          ),
          subtitle1: TextStyle(
            color: whiteColor,
            fontSize: 14,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0)),
            primary: kBGreen,
          ),
        ),
        buttonTheme: ButtonThemeData(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
          buttonColor: kBGreen,
        ));
  }
}
