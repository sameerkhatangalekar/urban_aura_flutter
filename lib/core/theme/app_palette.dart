

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

sealed class AppPalette {
  static const Color primaryCircle  = Color.fromRGBO(206, 147, 216, 1);
  static const Color secondaryCircle  = Color.fromRGBO(244, 143, 177, 1);
  static const Color tertiaryCircle  = Color.fromRGBO(255, 204, 128, 1);
  static const Color primaryColor = Color(0xFFA8715A);
  static const Color secondaryColor = Color(0xFFDD8560);

  static const Color line = Color(0xFFE0CFBA);

  static const Color inputBg = Color(0xFFF9F9F9);
  static const Color background = Color(0xFFF8F0E7);
  static const Color offWhite = Color(0xFFFCFCFC);
  static const Color cardBackground = Color(0xFFF2F2F2);



  static const Color titleActive = Color(0xFF000000);

  static const Color body = Color(0xFF333333);

  static const Color label = Color(0xFF555555);

  static const Color placeHolder = Color(0xFF888888);

}

sealed class AppThemeData {

  static ThemeData theme = ThemeData(
    scaffoldBackgroundColor:  AppPalette.offWhite,
    textTheme: GoogleFonts.tenorSansTextTheme(),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      centerTitle: true,
    ),
    inputDecorationTheme: InputDecorationTheme(
      isDense: true,
      hintStyle: const TextStyle(color: Colors.white70),
      fillColor: Colors.grey.shade900,
      filled:true,
      labelStyle: const TextStyle(color: Colors.white70),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide:
        const BorderSide(color: Colors.white12, width: 1),
      ),
      errorStyle: const TextStyle(color: Colors.redAccent),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide:
        const BorderSide(color: Colors.redAccent, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide:
        const BorderSide(color: Colors.redAccent, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide:
        const BorderSide(color: Colors.white70, width: 1),
      ),

    )
  );


}
