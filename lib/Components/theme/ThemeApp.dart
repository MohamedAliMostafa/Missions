
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do/Components/Colors/Colors.dart';

class Mytheme
{

  static ThemeData light_theme=ThemeData(
    primaryColor: light,
    scaffoldBackgroundColor: light,
    bottomAppBarTheme: BottomAppBarTheme(
      color: Colors.white
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: blueApp,
      unselectedItemColor: Gray,
    ),
    textTheme: TextTheme(
      bodyMedium: GoogleFonts.elMessiri(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),  // textAppbar
      labelLarge: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: blueApp
      ),   // title in taskContainer
      labelSmall: GoogleFonts.roboto(
        fontWeight: FontWeight.w400,
        fontSize: 12
      ),    // subTitle in taskContainer
      bodySmall: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Color(0xff383838)
      ) ,        // head bottomsheet
      labelMedium: GoogleFonts.poppins(
        fontSize: 10,
          fontWeight: FontWeight.bold,
        color: Colors.black
      ),                 // DATETIME

    )
  );
  static ThemeData dark_theme=ThemeData(
      primaryColor: dark,
      scaffoldBackgroundColor: dark,
      bottomAppBarTheme: BottomAppBarTheme(
          color: dark
      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: blueApp,
        unselectedItemColor: Colors.white,
      ),
      textTheme: TextTheme(
        bodyMedium: GoogleFonts.elMessiri(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),  // textAppbar
        labelLarge: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: blueApp
        ),   // title in taskContainer
        labelSmall: GoogleFonts.roboto(
            fontWeight: FontWeight.w400,
            color: Colors.blue,
            fontSize: 12
        ),    // subTitle in taskContainer
        bodySmall: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xff383838)
        ) ,        // head bottomsheet
        labelMedium: GoogleFonts.poppins(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: Colors.white
        ),       // DATEtIME

      )
  );
}