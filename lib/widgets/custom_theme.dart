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
        primaryColor: kBGreen,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Montserrat', //3
        textTheme: TextTheme(
            headline1: TextStyle(
          color: blue,
          fontSize: 16,
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
        primaryColor: bulbcolor,
        scaffoldBackgroundColor: Colors.black,
        fontFamily: 'Montserrat',
        textTheme: TextTheme(
          headline1: TextStyle(
            color: kGrey,
            fontSize: 16,
          ),
          bodyText1: TextStyle(
            color: kDark,
            fontSize: 18,
          ),
          subtitle1: TextStyle(
            color: kDarkGrey,
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
