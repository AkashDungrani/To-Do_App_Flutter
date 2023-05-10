import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

const Color bluecolour = Colors.orange;
const Color primarycolour = bluecolour;
const Color darkgreycolour = Color.fromARGB(255, 70, 59, 59);
Color darkheadercolour = Color(0xFF424242);
const Color white = Color.fromARGB(255, 159, 117, 117);
const Color lightbluecolour = Color.fromARGB(255, 83, 177, 253);
const Color greencolour = Color.fromARGB(255, 22, 128, 5);

class Themes {
  static final light = ThemeData(
    backgroundColor: Colors.white,
    primaryColor: primarycolour,
    brightness: Brightness.light,
  );
  static final dark = ThemeData(
    backgroundColor: darkgreycolour,
    primaryColor: darkgreycolour,
    brightness: Brightness.dark,
  );
}

TextStyle get subHeading {
  return GoogleFonts.poppins(
    textStyle: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: (Get.isDarkMode) ? Colors.grey[400] : Colors.grey,
    ),
  );
}

TextStyle get Heading {
  return GoogleFonts.poppins(
    textStyle: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: (Get.isDarkMode) ? Colors.white : Colors.black,
    ),
  );
}

TextStyle get titleStyle {
  return GoogleFonts.poppins(
    textStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: (Get.isDarkMode) ? Colors.white : Colors.black,
    ),
  );
}

TextStyle get subTitleStyle {
  return GoogleFonts.poppins(
      textStyle: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: (Get.isDarkMode) ? Colors.grey[100] : Colors.grey[400],
  ));
}
