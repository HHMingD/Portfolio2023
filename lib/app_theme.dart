import 'package:flutter/material.dart';

class Apptheme {
  static light() => ThemeData(
      useMaterial3: true,
      primaryColor: Apptheme.black,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.white)
          .copyWith(background: Apptheme.white, surfaceTint: Apptheme.white),
      primaryColorLight: Apptheme.prime200,
      primaryColorDark: Apptheme.prime800,
      textTheme: Apptheme.textThemeLight,
      primaryTextTheme: Apptheme.textThemeDark,
      dividerColor: Apptheme.black,
      hoverColor: Apptheme.prime100,
      highlightColor: Apptheme.prime200,
      splashColor: Apptheme.prime400,
      dividerTheme: const DividerThemeData(
        color: Apptheme.black,
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: Apptheme.white,
        surfaceTintColor: Apptheme.black,
        shadowColor: Apptheme.black,
      ),
      appBarTheme: const AppBarTheme(
        surfaceTintColor: Apptheme.noColor,
        backgroundColor: Apptheme.white,
        iconTheme: IconThemeData(
          color: Apptheme.black,
        ),
      ),
      iconTheme: const IconThemeData(
        color: Apptheme.black,
      ),
      expansionTileTheme: const ExpansionTileThemeData(
        collapsedTextColor: Apptheme.black,
        textColor: Apptheme.black,
        collapsedIconColor: Apptheme.black,
        iconColor: Apptheme.black,
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: Apptheme.black
  ),);

  static dark() => ThemeData(
      useMaterial3: true,
      primaryColor: Apptheme.white,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.black)
          .copyWith(background: Apptheme.black, surfaceTint: Apptheme.black),
      primaryColorLight: Apptheme.prime900,
      primaryColorDark: Apptheme.prime200,
      textTheme: Apptheme.textThemeDark,
      primaryTextTheme: Apptheme.textThemeLight,
      dividerColor: Apptheme.white,
      hoverColor: Apptheme.prime900,
      highlightColor: Apptheme.prime800,
      splashColor: Apptheme.prime600,
      dividerTheme: const DividerThemeData(
        color: Apptheme.white,
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: Apptheme.black,
        surfaceTintColor: Apptheme.white,
        shadowColor: Apptheme.white,
      ),
      appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(
          color: Apptheme.white,
        ),
        surfaceTintColor: Apptheme.noColor,
        backgroundColor: Apptheme.black,
      ),
      iconTheme: const IconThemeData(
        color: Apptheme.white,
      ),
      expansionTileTheme: const ExpansionTileThemeData(
        collapsedTextColor: Apptheme.white,
        textColor: Apptheme.white,
        collapsedIconColor: Apptheme.white,
        iconColor: Apptheme.white,
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: Apptheme.white
  ),
  );

  static const String fontName = 'Museo';
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color blue = Color(0xFF0047AB);
  static const Color imageContrast = Color(0x66EBECF1);
  static const Color prime100 = Color(0xFFDEDFE4);
  static const Color prime200 = Color(0xFFBDBFC9);
  static const Color prime300 = Color(0xFF9B9EAD);
  static const Color prime400 = Color(0xFF7A7E92);
  static const Color prime500 = Color(0xFF585D76);
  static const Color prime600 = Color(0xFF373D5B);
  static const Color prime700 = Color(0xFF151C3F);
  static const Color prime800 = Color(0xFF0C1023);
  static const Color prime900 = Color(0xFF080B16);
  static const Color prime950 = Color(0xFF020307);
  static const Color noColor = Color(0x00000000);

  static const TextTheme textThemeLight = TextTheme(
    headlineLarge: headlineLarge,
    headlineMedium: headlineMedium,
    headlineSmall: headlineSmall,
    titleLarge: titleLarge,
    titleMedium: titleMedium,
    titleSmall: titleSmall,
    bodyLarge: bodyLarge,
    bodyMedium: bodyMedium,
  );
  static TextTheme textThemeDark = TextTheme(
    headlineLarge: headlineLarge.copyWith(color: Apptheme.white),
    headlineMedium: headlineMedium.copyWith(color: Apptheme.white),
    headlineSmall: headlineSmall.copyWith(color: Apptheme.white),
    titleLarge: titleLarge.copyWith(color: Apptheme.white),
    titleMedium: titleMedium.copyWith(color: Apptheme.white),
    titleSmall: titleSmall.copyWith(color: Apptheme.white),
    bodyLarge: bodyLarge.copyWith(color: Apptheme.white),
    bodyMedium: bodyMedium.copyWith(color: Apptheme.white),
  );

  static const TextStyle headlineLarge = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w700,
    fontSize: 40,
    letterSpacing: -0.3,
  );
  static const TextStyle headlineMedium = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w700,
    fontSize: 32,
    letterSpacing: -0.2,
  );
  static const TextStyle headlineSmall = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w700,
    fontSize: 28,
    letterSpacing: -0.15,
  );
  static const TextStyle titleTiny = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w700,
    fontSize: 24,
    letterSpacing: -0.15,
  );
  static const TextStyle titleLarge = TextStyle(
    height: 1.5,
    fontFamily: fontName,
    fontWeight: FontWeight.w500,
    fontSize: 20,
    letterSpacing: -0.4,
  );
  static const TextStyle titleMedium = TextStyle(
    height: 1.5,
    fontFamily: fontName,
    fontWeight: FontWeight.w500,
    fontSize: 18,
    letterSpacing: -0.4,
  );
  static const TextStyle titleSmall = TextStyle(
    height: 1.4,
    fontFamily: fontName,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    letterSpacing: -0.3,
  );

  static const TextStyle titleSmallHC = TextStyle(
    height: 1.4,
    fontFamily: fontName,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    letterSpacing: -0.3,
  );
  static const TextStyle labelTiny = TextStyle(
    height: 1.3,
    fontFamily: fontName,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    letterSpacing: -0.3,
  );
  static const TextStyle labelTinyHC = TextStyle(
    height: 1.3,
    fontFamily: fontName,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    letterSpacing: -0.3,
  );
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w500,
    fontSize: 18,
    letterSpacing: 0.1,
  );
  static const TextStyle bodyMedium = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    letterSpacing: 0.1,
  );
}
