import 'package:flutter/material.dart';

class Apptheme {
  static const String fontName = 'Sora';
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

  static const TextStyle titleLarge = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w700,
    fontSize: 40,
    letterSpacing: -0.2,
    color: prime600,
  );
  static const TextStyle titleBase = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w700,
    fontSize: 32,
    letterSpacing: 0,
    color: prime600,
  );
  static const TextStyle titleSmall = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w700,
    fontSize: 28,
    letterSpacing: 0,
    color: prime600,
  );
  static const TextStyle titleTiny = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w700,
    fontSize: 24,
    letterSpacing: 0,
    color: prime600,
  );
  static const TextStyle labelLarge = TextStyle(
    height: 1.5,
    fontFamily: fontName,
    fontWeight: FontWeight.w600,
    fontSize: 20,
    letterSpacing: 0.15,
    color: prime600,
  );
  static const TextStyle labelBase = TextStyle(
    height: 1.5,
    fontFamily: fontName,
    fontWeight: FontWeight.w600,
    fontSize: 18,
    letterSpacing: 0.1,
    color: prime600,
  );
  static const TextStyle labelSmall = TextStyle(
    height: 1.4,
    fontFamily: fontName,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    letterSpacing: 0.1,
    color: prime600,
  );
  static const TextStyle labelTiny = TextStyle(
    height: 1.3,
    fontFamily: fontName,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    letterSpacing: 0.1,
    color: prime700,
  );
  static const TextStyle labelSmallHC = TextStyle(
    height: 1.4,
    fontFamily: fontName,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    letterSpacing: 0.1,
    color: prime100,
  );
  static const TextStyle labelTinyHC = TextStyle(
    height: 1.3,
    fontFamily: fontName,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    letterSpacing: 0.1,
    color: prime100,
  );
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 18,
    letterSpacing: 0.5,
    color: prime900,
  );
  static const TextStyle bodyBase = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: 0.5,
    color: prime900,
  );
  static const TextStyle bodySmall = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 0.25,
    color: prime900,
  );
  static const TextStyle bodyTiny = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w500,
    fontSize: 12,
    letterSpacing: 0.25,
    color: prime900,
  );
}
