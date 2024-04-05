import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:go_router/go_router.dart';
import 'package:howard_chen_portfolio/pages/home_page_content.dart';
import 'package:howard_chen_portfolio/widgets/navigation.dart';
import 'firebase_options.dart';
import 'style/app_theme.dart';
import 'functions/json_parse.dart';
import 'functions/network.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



FirebaseAnalytics analytics = FirebaseAnalytics.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;

bool unlocked = false;
bool deviceIsDesktop = true;
late BuildContext universalContext;
late JsonStructure jsonContent;

void main() async {
  setUrlStrategy(PathUrlStrategy());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Howard Chen Portfolio',
      theme: Apptheme.light(),
//      darkTheme: Apptheme.dark(),
//      darkTheme: getAppTheme(context, true),
//      themeMode: ThemeMode.system,
      routerConfig: customRouter,
    );
  }
}

class FetchData extends StatefulWidget {
  const FetchData({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<FetchData> createState() => _FetchDataState();
}

class _FetchDataState extends State<FetchData> {
  late Future<JsonStructure> myFuture;

  @override
  void initState() {
    myFuture = readJsonStructureOnline();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    universalContext = context;
    return FutureBuilder(
        future: myFuture,
        builder: (BuildContext context, AsyncSnapshot<JsonStructure> snapshot) {
          if (snapshot.hasData) {

            jsonContent = snapshot.data!;
            return ResponsiveBuilder(
              navigationShell: widget.navigationShell,
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                    style: Theme.of(universalContext).textTheme.labelLarge,
                    'Website is initiating...'),
                Styling.contentMediumSpacing,
                Styling.centerCircularProgressIndicator,
              ],
            );
          }
        });
  }
}

class ResponsiveBuilder extends StatefulWidget {
  const ResponsiveBuilder({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<ResponsiveBuilder> createState() => _ResponsiveBuilderState();
}

class _ResponsiveBuilderState extends State<ResponsiveBuilder> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      deviceIsDesktop = constraints.maxWidth > 800;
      return NavigationShell(navigationShell: widget.navigationShell);
    });
  }
}
