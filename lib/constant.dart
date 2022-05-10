import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supercharged/supercharged.dart';

double kPaddingHorizontal = 16;
double kPaddingVertical = 10;
double kPadding = 24;

TextStyle kBlackFontStyle = GoogleFonts.openSans().copyWith(
  fontSize: 14,
  color: Colors.black,
  fontWeight: FontWeight.w500,
);

TextStyle kBlackFontStyle2 = GoogleFonts.openSans().copyWith(
  fontSize: 12,
  color: Colors.black54,
  fontWeight: FontWeight.w500,
);

TextStyle kWhiteFontStyle = GoogleFonts.openSans(
  textStyle: const TextStyle(
    color: Colors.white,
    fontSize: 14,
    fontWeight: FontWeight.w600,
  ),
);

TextStyle kWhiteFontStyle2 = GoogleFonts.openSans(
  textStyle: const TextStyle(
    color: Color(0xffa29aac),
    fontSize: 14,
    fontWeight: FontWeight.w600,
  ),
);

TextStyle kWhiteFontStyle3 = GoogleFonts.robotoMono().copyWith(
  fontSize: 1,
  color: Colors.white70,
  fontWeight: FontWeight.w500,
);

const kButtonPrimaryColor = Color(0xFF6F35A5);
const kButtonPrimaryLightColor = Color(0xFFF1E6FF);

Color kPrimary = const Color(0xff392850);
Color kSecondary = const Color(0xff453658);
Color kListCardColor = const Color(0xffc8c7d6);

Color kColorMain = '#FFFFFF'.toColor();

Color kColorMain1 = '#D2D6DB'.toColor();
Color kColorMain2 = '#EDEFF2'.toColor();

Color kColorSecondary = '#OCOCOCE'.toColor();
Color kColorSecondary1 = '#9CA1A7'.toColor();
Color kColorSecondary2 = '#45484D'.toColor();

Color kColorAlertRed = '#EB5757'.toColor();
Color kColorAlertGreen = '#53BF81'.toColor();
Color kColorAlertBlue = '#4286E1'.toColor();
Color kColorAlertPurple = '#A066D7'.toColor();

class ApiConstants {
  static String baseUrl = 'https://siapbaper.bbmakmur.com/api';
  // static String baseUrl = 'http://127.0.0.1:8000/api';
  // static String baseUrl = 'http://192.168.1.24:8000/api';

// Bearer 4|xYmmGmblOC1j0OXcTRnE98hP5vrpYw2JtERvi3tx
}
