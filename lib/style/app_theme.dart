import 'package:flutter/material.dart';
import 'package:howard_chen_portfolio/widgets/utility_widgets.dart';
import '../functions/json_parse.dart';
import '../functions/network.dart';
import '../main.dart';

class Apptheme {
  static light() => ThemeData(
        useMaterial3: true,
        primaryColor: Apptheme.black,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white)
            .copyWith(background: Apptheme.white, surfaceTint: Apptheme.white),
        primaryColorLight: Apptheme.prime200,
        primaryColorDark: Apptheme.prime900,
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
          backgroundColor: Apptheme.noColor,
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
        progressIndicatorTheme:
            const ProgressIndicatorThemeData(color: Apptheme.black),
      );

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
        progressIndicatorTheme:
            const ProgressIndicatorThemeData(color: Apptheme.white),
      );

  static const String fontName = 'Montserrat';
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color blue = Color(0xFF0047AB);
  static const Color imageContrast = Color(0x66EBECF1);
  static const Color prime100 = Color(0xFFF3F4F8);
  static const Color prime200 = Color(0xFFCDD2E3);
  static const Color prime300 = Color(0xFFA7AFCD);
  static const Color prime400 = Color(0xFF818DB7);
  static const Color prime500 = Color(0xFF5A6AA1);
  static const Color prime600 = Color(0xFF34488C);
  static const Color prime700 = Color(0xFF0E2576);
  static const Color prime800 = Color(0xFF0A1951);
  static const Color prime900 = Color(0xFF050E2B);
  static const Color prime950 = Color(0xFF010206);
  static const Color noColor = Color(0x00000000);

  static const TextTheme textThemeLight = TextTheme(
    headlineLarge: headlineLarge,
    headlineMedium: headlineMedium,
    headlineSmall: headlineSmall,
    titleLarge: titleLarge,
    titleMedium: titleMedium,
    titleSmall: titleSmall,
    labelLarge: labelLarge,
    labelMedium: labelMedium,
    labelSmall: labelSmall,
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
    labelLarge: labelLarge.copyWith(color: Apptheme.white),
    labelMedium: labelMedium.copyWith(color: Apptheme.white),
    labelSmall: labelSmall.copyWith(color: Apptheme.white),
    bodyLarge: bodyLarge.copyWith(color: Apptheme.white),
    bodyMedium: bodyMedium.copyWith(color: Apptheme.white),
  );

  static const TextStyle headlineLarge = TextStyle(
    height: 1.2,
    fontFamily: "Museo",
    fontWeight: FontWeight.w700,
    fontSize: 48,
    letterSpacing: -1.2,
  );
  static const TextStyle headlineMedium = TextStyle(
    fontFamily: "Museo",
    fontWeight: FontWeight.w700,
    fontSize: 40,
    letterSpacing: -0.8,
  );
  static const TextStyle headlineSmall = TextStyle(
    fontFamily: "Museo",
    fontWeight: FontWeight.w800,
    fontSize: 32,
    letterSpacing: -0.5,
  );
  static const TextStyle titleLarge = TextStyle(
    height: 1.2,
    fontFamily: "Museo",
    fontWeight: FontWeight.w700,
    fontSize: 28,
    letterSpacing: -1,
  );
  static const TextStyle titleMedium = TextStyle(
    height: 1.2,
    fontFamily: "Museo",
    fontWeight: FontWeight.w700,
    fontSize: 24,
    letterSpacing: -0.5,
  );
  static const TextStyle titleSmall = TextStyle(
    height: 1.15,
    fontFamily: "Museo",
    fontWeight: FontWeight.w700,
    fontSize: 20,
    letterSpacing: -0.5,
  );
  static const TextStyle labelLarge = TextStyle(
    height: 1.3,
    fontFamily: fontName,
    fontWeight: FontWeight.w600,
    fontSize: 18,
    letterSpacing: -0.8,
  );
  static const TextStyle labelMedium = TextStyle(
    height: 1.3,
    fontFamily: fontName,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    letterSpacing: -0.6,
  );
  static const TextStyle labelSmall = TextStyle(
    height: 1.2,
    fontFamily: fontName,
    fontWeight: FontWeight.w600,
    fontSize: 14,
    letterSpacing: -0.4,
  );
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    letterSpacing: 0,
  );
  static const TextStyle bodyMedium = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    letterSpacing: 0,
  );
}

class Styling {
  static const Widget centerCircularProgressIndicator = Center(
    child: SizedBox(height: 50, width: 50, child: CircularProgressIndicator()),
  );

  static Widget topBottomSpacing = SizedBox(
    height: deviceIsDesktop
        ? MediaQuery.of(universalContext).size.height * 0.40
        : 48,
  );

  static Widget contentLargeSpacing = SizedBox(
    width: deviceIsDesktop ? 24 : 16,
    height: deviceIsDesktop ? 32 : 24,
  );

  static Widget contentMediumSpacing = SizedBox(
    width: deviceIsDesktop ? 12 : 12,
    height: deviceIsDesktop ? 16 : 12,
  );

  static Widget contentSmallSpacing = SizedBox(
    width: deviceIsDesktop ? 8 : 8,
    height: deviceIsDesktop ? 12 : 8,
  );

  static Widget gridSpacing = SizedBox(
    width: deviceIsDesktop ? 32 : 16,
    height: deviceIsDesktop ? 24 : 16,
  );
  static double defaultSpacing = deviceIsDesktop ? 32.0 : 16.0;

  static Widget horizontalGridSpacing = SizedBox(
    width: deviceIsDesktop ? 32 : 16,
  );

  static Widget dividerSmallSpacing = Column(
    children: <Widget>[
      const SizedBox(
        height: 15,
      ),
      Divider(
        height: 1,
        color: Theme.of(universalContext).primaryColor,
      ),
      const SizedBox(
        height: 15,
      ),
    ],
  );

  static Widget dividerLargeSpacing = Column(
    children: <Widget>[
      const SizedBox(
        height: 23,
      ),
      Divider(
        height: 1,
        color: Theme.of(universalContext).primaryColor,
      ),
      const SizedBox(
        height: 23,
      ),
    ],
  );

  static Widget dividerSmallSpacingHighContrast = Column(
    children: <Widget>[
      const SizedBox(
        height: 15,
      ),
      Divider(
        height: 1,
        color: Theme.of(universalContext).scaffoldBackgroundColor,
      ),
      const SizedBox(
        height: 15,
      ),
    ],
  );

  static Widget dividerLargeSpacingHighContrast = Column(
    children: <Widget>[
      const SizedBox(
        height: 23,
      ),
      Divider(
        height: 1,
        color: Theme.of(universalContext).scaffoldBackgroundColor,
      ),
      const SizedBox(
        height: 23,
      ),
    ],
  );

  static EdgeInsetsGeometry smallPadding = EdgeInsets.symmetric(
      horizontal: deviceIsDesktop ? 12 : 8, vertical: deviceIsDesktop ? 8 : 4);

  static EdgeInsetsGeometry mediumPadding =
      EdgeInsets.all(deviceIsDesktop ? 24 : 16);

  static EdgeInsetsGeometry largePadding =
      EdgeInsets.all(deviceIsDesktop ? 32 : 24);

  static BoxDecoration focusTabState = const BoxDecoration(
      border: Border(bottom: BorderSide(width: 4, color: Apptheme.prime500)));

  static BoxDecoration defaultTabState = const BoxDecoration(
      border: Border(bottom: BorderSide(width: 2, color: Apptheme.prime100)));

  static BoxDecoration hoveredTabState = const BoxDecoration(
      border: Border(bottom: BorderSide(width: 2, color: Apptheme.prime300)));

  static BoxDecoration hoveredState = BoxDecoration(
      color: Theme.of(universalContext).scaffoldBackgroundColor,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(width: 1, color: Apptheme.light().primaryColor));

  static BoxDecoration focusState = BoxDecoration(
      color: Theme.of(universalContext).primaryColor,
      borderRadius: BorderRadius.circular(10));

  static BoxDecoration defaultState = BoxDecoration(
      color: Theme.of(universalContext).scaffoldBackgroundColor,
      borderRadius: BorderRadius.circular(10));

  static BoxDecoration disabledState = BoxDecoration(
      color: Theme.of(universalContext).primaryColorLight,
      borderRadius: BorderRadius.circular(10));

  static BoxDecoration elevatedState = BoxDecoration(
      color: Theme.of(universalContext).scaffoldBackgroundColor,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(width: 1));

  static BoxDecoration defaultHighContrastState = BoxDecoration(
      color: Theme.of(universalContext).primaryColorDark,
      borderRadius: BorderRadius.circular(10));

  static InputDecoration defaultInputDecoration(
      String hintText, String errorText, bool dataIncorrect,
      {bool highContrast = false}) {
    return InputDecoration(
      contentPadding: EdgeInsets.only(
        left: deviceIsDesktop ? 16 : 8,
        right: deviceIsDesktop ? 16 : 8,
        top: deviceIsDesktop ? 20 : 12,
        bottom: deviceIsDesktop ? 19 : 11,
      ),
      isDense: true,
      border: OutlineInputBorder(
          borderSide: BorderSide(
              color: highContrast
                  ? Theme.of(universalContext).scaffoldBackgroundColor
                  : Theme.of(universalContext).primaryColor,
              width: 1.0)),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: highContrast
                  ? Theme.of(universalContext).scaffoldBackgroundColor
                  : Theme.of(universalContext).primaryColor,
              width: 2.0)),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: highContrast
                  ? Theme.of(universalContext).scaffoldBackgroundColor
                  : Theme.of(universalContext).primaryColor,
              width: 1.0)),
      hintText: hintText,
      hintStyle: Apptheme.labelMedium
          .copyWith(color: Theme.of(universalContext).primaryColorLight),
      errorText: dataIncorrect ? errorText : null,
    );
  }

  static Widget pageFrame(
      {Widget child = const SizedBox(height: 16),
      Widget leftChild = const SizedBox(height: 16),
      Widget rightChild = const SizedBox(height: 16),
      Widget secondaryChild = const SizedBox(height: 16),
      Widget bannerChild = const SizedBox()}) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Styling.contentLargeSpacing,
          Container(
            constraints: const BoxConstraints(maxWidth: 1400),
            child: Row(
              children: [
                Styling.horizontalGridSpacing,
                Expanded(child: bannerChild),
                Styling.horizontalGridSpacing,
              ],
            ),
          ),
          Styling.contentSmallSpacing,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Styling.horizontalGridSpacing,
              deviceIsDesktop
                  ? Expanded(flex: 1, child: leftChild)
                  : const SizedBox(),
              deviceIsDesktop ? Styling.gridSpacing : const SizedBox(),
              Container(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: child),
              deviceIsDesktop ? Styling.gridSpacing : const SizedBox(),
              deviceIsDesktop
                  ? Expanded(flex: 1, child: rightChild)
                  : const SizedBox(),
              Styling.horizontalGridSpacing,
            ],
          ),
          Styling.contentSmallSpacing,
          Row(
            children: [
              Styling.horizontalGridSpacing,
              Expanded(child: secondaryChild),
              Styling.horizontalGridSpacing,
            ],
          ),
          Styling.contentLargeSpacing,
          const Footer(),
        ],
      ),
    );
  }

  static Widget defaultPaper({
    bool highContrast = false,
    bool hasMargin = false,
    bool hasPadding = true,
    double maxWidth = double.infinity,
    required Widget child,
  }) {
    return Container(
      constraints: BoxConstraints(maxWidth: maxWidth),
      margin: hasMargin ? mediumPadding : null,
      padding: hasPadding ? mediumPadding : null,
      decoration: highContrast ? defaultHighContrastState : defaultState,
      child: child,
    );
  }

  static Widget largePaper({
    bool highContrast = false,
    bool hasMargin = false,
    bool hasPadding = true,
    double maxWidth = double.infinity,
    required Widget child,
  }) {
    return Container(
      constraints: BoxConstraints(maxWidth: maxWidth),
      margin: hasMargin ? mediumPadding : null,
      padding: hasPadding ? mediumPadding : null,
      decoration: highContrast ? defaultHighContrastState : defaultState,
      child: child,
    );
  }
}
