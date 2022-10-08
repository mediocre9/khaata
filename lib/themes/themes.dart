import 'package:flutter/material.dart';
import 'package:khata/constants.dart';

class AppTheme {
  static ThemeData lightTheme() {
    return ThemeData.light().copyWith(
      /// [Appbar] theme
      appBarTheme: const AppBarTheme(
        backgroundColor: kAppBarBackColor,
        foregroundColor: Colors.black,
        toolbarHeight: 65,
        elevation: 1.1,
        toolbarTextStyle: TextStyle(fontFamily: 'Roboto'),
      ),
      brightness: Brightness.light,
      scaffoldBackgroundColor: kScaffoldColor,

      /// [TextTheme] for search area as caption
      textTheme: const TextTheme(
        labelMedium: TextStyle(
          fontSize: 11,
          letterSpacing: 0.8,
          fontWeight: FontWeight.bold,
          color: kTextColor,
        ),
      ),

      // textbutton
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: kTextColor),
      ),

      // textfield
      inputDecorationTheme: InputDecorationTheme(
        isDense: true,
        contentPadding: const EdgeInsets.all(8),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 1,
          ),
        ),
      ),

      // outlined button
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.transparent,
          shape: const BeveledRectangleBorder(),
          side: const BorderSide(
            color: Color.fromRGBO(222, 231, 255, 1.0),
            width: 1.2,
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      // list tile
      listTileTheme: ListTileThemeData(
        dense: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        textColor: kCardTextColor,
        minVerticalPadding: 6,
      ),

      // card theme
      cardTheme: CardTheme(
        color: kBlueGradient,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      ),
    );
  }
}
