

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

sealed class AppPalette {
  
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

  );


}
