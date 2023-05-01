import 'package:budgetplanner/widgets/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

String titleFont = GoogleFonts.lato().fontFamily!;
String headerFont = GoogleFonts.lato().fontFamily!;

///
///hl1- {34,1.3,opacity-.8}
///hl2- {28,1.3,op-.8}
///hl3-{22,-,-}
///hl4-{18,--}
///hl5-{16,--}
///hl6-{14,--}
///subt-{12,1.4,-}
///subl2-{14,--}
///bt1-{13,1.4}
///bt2-{11,1.4}
final kHeadlineLarge = TextStyle(
  fontFamily: GoogleFonts.oswald().fontFamily,
  color: shade,
  fontSize: 34.0,
  height: 1.3,
);
final kHeadlineMedium = TextStyle(
  fontFamily: titleFont,
  color: kPink,
  fontSize: 22.0,
  height: 1.3,
);
final kHeadlineSmall = TextStyle(
  fontFamily: titleFont,
  color: kPink,
  fontSize: 28.0,
  height: 1.3,
);
final kTittleMedium = TextStyle(
  fontFamily: titleFont,
  fontSize: 12.0,
  height: 1.4,
);
final kTittleLarge = TextStyle(
  fontFamily: titleFont,
  fontSize: 14.0,
  height: 1.4,
);
final kBodySmall = TextStyle(
  fontFamily: titleFont,
  fontSize: 11.0,
  height: 1.4,
);
final kBodyMedium = TextStyle(
  fontFamily: titleFont,
  fontSize: 12.0,
  height: 1.4,
);
final kBodyLarge = TextStyle(
  fontFamily: titleFont,
  fontSize: 13.0,
  height: 1.4,
);

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
