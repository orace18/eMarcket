import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../helpers/constants.dart';

class AppTheme {

  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primarySwatch: easyMarketMaterial,
    appBarTheme: AppBarTheme(
      color: easyMarketGreen,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
    ),
    textTheme: GoogleFonts.robotoTextTheme(),
    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.0)
      ),
      color: easyMarketMaterial[50],
      elevation: 12.0,
    ),
    buttonTheme: ButtonThemeData(
        padding: EdgeInsets.all(8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.0),
        )
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
              EdgeInsets.all(12)
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)
            ),
          ),
          iconColor: MaterialStateProperty.all(
              Colors.blueGrey
          ),
        )
    ),
    iconTheme: IconThemeData(
      color: Colors.white54,
    ),
    fontFamily: GoogleFonts.roboto().fontFamily,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,//Color.fromARGB(236, 247, 236, 236),
      selectedItemColor: Colors.green[800],
      unselectedItemColor: Colors.blue,
      // selectedItemColor: Colors.green[800].withOpacity(0.7),
      // unselectedItemColor: Colors.green[800].withOpacity(0.32),
      showUnselectedLabels: true,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey[900],
    appBarTheme: AppBarTheme(
      color: Colors.grey[900],
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    colorScheme: ColorScheme.dark(
      primary: Colors.black26,
      onPrimary: Colors.black26,
      secondary: Colors.green,
    ),
    cardTheme: CardTheme(
      color: Colors.grey[800],
    ),
    iconTheme: IconThemeData(
      color: Colors.grey[400],
    ),
    fontFamily: GoogleFonts.roboto().fontFamily,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.grey[800],
      selectedItemColor: Colors.green[800],
      unselectedItemColor: Colors.grey[400],
      showUnselectedLabels: true,
    ),
  );

  static const MaterialColor easyMarketMaterial = MaterialColor(_easyMarketMaterialPrimaryValue, <int, Color>{
    50: Color(0xFFF7ECEC),
    100: Color(0xFF593535),
    200: Color(0xFF00684E),
    300: Color(0xFF593535),
    400: Color(0xFF00752E),
    500: Color(_easyMarketMaterialPrimaryValue),
    600: Color(0xFF00552E),
    700: Color(0xFF00533E),
    800: Color(0xFF00562E),
    900: Color(0xFF00572E),
  });
  static const int _easyMarketMaterialPrimaryValue = 0xFF593535;

  static const MaterialColor easyMarketMaterialAccent = MaterialColor(_easyMarketMaterialAccentValue, <int, Color>{
    100: Color(0xFFFFFFFF),
    200: Color(_easyMarketMaterialAccentValue),
    400: Color(0xFF7ECFFE),
    700: Color(0xFF7ED3FE),
  });

  static const int _easyMarketMaterialAccentValue = 0xFF7ECDDE;
}