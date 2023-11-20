import 'package:flutter/material.dart';

ThemeData getAppTheme(BuildContext context, bool isDarkTheme) {
  return ThemeData(
    scaffoldBackgroundColor: isDarkTheme ? Colors.black : Colors.white,
    textTheme: Theme.of(context)
        .textTheme
        .copyWith(
          headlineLarge: Apptheme.titleSmall.copyWith(color: Apptheme.white),
          headlineMedium:
              Apptheme.headlineMedium.copyWith(color: Apptheme.white),
          headlineSmall: Apptheme.headlineSmall.copyWith(color: Apptheme.white),
          titleLarge: Apptheme.titleLarge.copyWith(color: Apptheme.white),
          titleMedium: Apptheme.titleMedium.copyWith(color: Apptheme.white),
          titleSmall: Apptheme.titleSmall.copyWith(color: Apptheme.white),
          bodyLarge: Apptheme.bodyLarge.copyWith(color: Apptheme.white),
          bodyMedium: Apptheme.bodyMedium.copyWith(color: Apptheme.white),
        )
        .apply(
          bodyColor: isDarkTheme ? Colors.white : Colors.black,
          displayColor: Colors.grey,
        ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.all(
          isDarkTheme ? Colors.orange : Colors.purple),
    ),
    listTileTheme: ListTileThemeData(
        iconColor: isDarkTheme ? Colors.orange : Colors.purple),
    appBarTheme: AppBarTheme(
        backgroundColor: isDarkTheme ? Colors.black : Colors.white,
        iconTheme:
            IconThemeData(color: isDarkTheme ? Colors.white : Colors.black54)),
  );
}

class Apptheme {
  static ThemeData themeData = ThemeData(
      useMaterial3: true,
      primaryColor: Apptheme.black,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.white)
          .copyWith(background: Apptheme.white, surfaceTint: Apptheme.white),
      primaryColorLight: Apptheme.white,
      primaryColorDark: Apptheme.black,
      textTheme: Apptheme.textTheme);

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
  static const Color prime900 = Color(0xFF020307);
  static const Color noColor = Color(0x00000000);

  static const TextTheme textTheme = TextTheme(
    headlineLarge: headlineLarge,
    headlineMedium: headlineMedium,
    headlineSmall: headlineSmall,
    titleLarge: titleLarge,
    titleMedium: titleMedium,
    titleSmall: titleSmall,
    bodyLarge: bodyLarge,
    bodyMedium: bodyMedium,
  );

  static const TextStyle headlineLarge = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w700,
    fontSize: 40,
    letterSpacing: -0.3,
    color: prime600,
  );
  static const TextStyle headlineMedium = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w700,
    fontSize: 32,
    letterSpacing: -0.2,
    color: prime600,
  );
  static const TextStyle headlineSmall = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w700,
    fontSize: 28,
    letterSpacing: -0.15,
    color: prime600,
  );
  static const TextStyle titleTiny = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w700,
    fontSize: 24,
    letterSpacing: -0.15,
    color: prime600,
  );
  static const TextStyle titleLarge = TextStyle(
    height: 1.5,
    fontFamily: fontName,
    fontWeight: FontWeight.w500,
    fontSize: 20,
    letterSpacing: -0.4,
    color: prime600,
  );
  static const TextStyle titleMedium = TextStyle(
    height: 1.5,
    fontFamily: fontName,
    fontWeight: FontWeight.w500,
    fontSize: 18,
    letterSpacing: -0.4,
    color: prime600,
  );
  static const TextStyle titleSmall = TextStyle(
    height: 1.4,
    fontFamily: fontName,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    letterSpacing: -0.3,
    color: prime600,
  );

  static const TextStyle titleSmallHC = TextStyle(
    height: 1.4,
    fontFamily: fontName,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    letterSpacing: -0.3,
    color: prime100,
  );
  static const TextStyle labelTiny = TextStyle(
    height: 1.3,
    fontFamily: fontName,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    letterSpacing: -0.3,
    color: prime700,
  );
  static const TextStyle labelTinyHC = TextStyle(
    height: 1.3,
    fontFamily: fontName,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    letterSpacing: -0.3,
    color: prime100,
  );
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w500,
    fontSize: 18,
    letterSpacing: 0.1,
    color: prime900,
  );
  static const TextStyle bodyMedium = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    letterSpacing: 0.1,
    color: prime900,
  );
}
