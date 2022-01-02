import 'package:budgetplanner/widgets/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

String titleFont = GoogleFonts.lato().fontFamily!;
String headerFont = GoogleFonts.lato().fontFamily!;

final kTitleStyle = TextStyle(
  fontFamily: GoogleFonts.oswald().fontFamily,
  color: kPink,
  fontSize: 40.0,
  fontWeight: FontWeight.bold,
  letterSpacing: 0.4,
  height: 1.2,
);
final kTitleStyleSmall = TextStyle(
  fontFamily: titleFont,
  color: kPink,
  fontSize: 30.0,
  fontWeight: FontWeight.bold,
  letterSpacing: 0.4,
  height: 1.2,
);

final kQuoteStyle = TextStyle(
    fontFamily: titleFont,
    color: greyColor,
    fontSize: 16.0,
    letterSpacing: 0.4,
    fontStyle: FontStyle.italic);

final kHeaderStyle = TextStyle(
  fontFamily: titleFont,
  color: kGrey,
  fontSize: 18.0,
  letterSpacing: 0.4,
);

final kSubtitleStyle = TextStyle(
  fontFamily: titleFont,
  color: kGrey,
  fontSize: 18.0,
  letterSpacing: 0.4,
  height: 1.2,
);

final kLabelStyle = TextStyle(
  fontFamily: titleFont,
  color: kDarkGrey,
  fontSize: 14.0,
  letterSpacing: 0.4,
  height: 1.2,
);

final kLabelStyleBold = TextStyle(
  fontFamily: headerFont,
  color: kDarkGrey,
  fontSize: 14.0,
  letterSpacing: 0.4,
  fontWeight: FontWeight.bold,
  height: 1.2,
);

final kButtonStyle = TextStyle(
  fontFamily: titleFont,
  color: kDarkGrey,
  fontSize: 16.0,
);
