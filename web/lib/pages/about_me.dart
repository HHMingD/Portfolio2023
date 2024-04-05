import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../main.dart';
import '../style/app_theme.dart';
import '../widgets/book_utilities.dart';
import '../widgets/navigation.dart';
import '../widgets/utility_widgets.dart';
import 'book_recommendation.dart';

class AboutMeContent extends StatelessWidget {
  const AboutMeContent({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

class AboutMeShell extends StatelessWidget {
  const AboutMeShell({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

class BookExchangeShell extends StatelessWidget {
  const BookExchangeShell({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

class IntroWidgetsRotate extends StatefulWidget {
  const IntroWidgetsRotate({super.key, required this.widgets});

  final List<Widget> widgets;

  @override
  State<StatefulWidget> createState() => IntroWidgetsRotateState();
}

class IntroWidgetsRotateState extends State<IntroWidgetsRotate> {
  @override
  int i = 0;
  Duration oneSec = const Duration(seconds: 4);

  void initState() {
    super.initState();
    Timer.periodic(
        oneSec,
        (Timer t) => setState(() {
              i = i + 1;
            }));
  }

  Widget build(BuildContext context) {
    return widget.widgets[i % 4];
  }
}

class AboutMe extends StatelessWidget {
  const AboutMe({super.key});

  static List<Widget> introWidgets(BuildContext context, bool condensed) => [
        _myInterests(context, true),
        _myTools(context, true),
        _contactMe(context, true),
        profile(context, true)
      ];

  static Widget _myInterests(BuildContext context, bool condensed) {
    return Container(
      height: condensed ? null : 340,
      width: !condensed
          ? MediaQuery.of(context).size.width * 0.3
          : double.infinity,
      child: Styling.defaultPaper(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(FontAwesomeIcons.solidHeart),
                Styling.contentSmallSpacing,
                const Expanded(
                  child: Text(
                    'My Interests',
                    style: Apptheme.titleMedium,
                  ),
                ),
              ],
            ),
            Styling.contentMediumSpacing,
            const Text(
              '>  Badminton',
              style: Apptheme.labelMedium,
            ),
            Styling.contentSmallSpacing,
            const Text(
              '>  Guitar',
              style: Apptheme.labelMedium,
            ),
            Styling.contentSmallSpacing,
            const Text(
              '>  Plastic Models',
              style: Apptheme.labelMedium,
            ),
            Styling.contentSmallSpacing,
            const Text(
              '>  Experimenting with Fusion Food',
              style: Apptheme.labelMedium,
            ),
          ],
        ),
      ),
    );
  }

  static Widget _myTools(BuildContext context, bool condensed) {
    return Container(
      height: condensed ? null : 340,
      width: !condensed
          ? MediaQuery.of(context).size.width * 0.3
          : double.infinity,
      child: Styling.defaultPaper(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(FontAwesomeIcons.wrench),
                Styling.contentSmallSpacing,
                const Expanded(
                  child: Text(
                    'My Tools',
                    style: Apptheme.titleMedium,
                  ),
                ),
              ],
            ),
            Styling.contentMediumSpacing,
            const Text(
              '>  Figma',
              style: Apptheme.labelMedium,
            ),
            Styling.contentSmallSpacing,
            const Text(
              '>  Adobe',
              style: Apptheme.labelMedium,
            ),
            Styling.contentSmallSpacing,
            const Text(
              '>  Unity',
              style: Apptheme.labelMedium,
            ),
            Styling.contentSmallSpacing,
            const Text(
              '>  Flutter',
              style: Apptheme.labelMedium,
            ),
          ],
        ),
      ),
    );
  }

  static Widget _bookExchange(BuildContext context, bool condensed) {
    return Container(
      height: condensed ? null : 340,
      width: !condensed
          ? MediaQuery.of(context).size.width * 0.3
          : double.infinity,
      child: Styling.defaultPaper(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(FontAwesomeIcons.book),
                Styling.contentMediumSpacing,
                const Expanded(
                  child: Text(
                    'Book Exchange:',
                    style: Apptheme.titleMedium,
                  ),
                ),
              ],
            ),
            Styling.contentMediumSpacing,
            FutureBuilder(
                future: booksInProgress.orderBy('addedBy', descending: true).get(),
                builder:
                    (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData && snapshot.data?.docs != []) {
                    return QuickBookPreview(id: snapshot.data!.docs[0]['bookID']);
                  } else {
                    return const Text(
                        'Out of book to read! Recommended me some nice ones?',
                        style: Apptheme.labelMedium);
                  }
                }),
          ],
        ),
      ),
    );
  }

  static Widget _contactMe(BuildContext context, bool condensed) {
    return Container(
      height: condensed ? null : 340,
      width: !condensed
          ? MediaQuery.of(context).size.width * 0.3
          : double.infinity,
      child: Styling.defaultPaper(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(FontAwesomeIcons.solidMessage),
                Styling.contentMediumSpacing,
                const Expanded(
                  child: Text(
                    'Contact Me',
                    style: Apptheme.titleMedium,
                  ),
                ),
              ],
            ),
            Styling.contentMediumSpacing,
            HoverEffect(
              backGroundColor: Apptheme.prime100,
              child: Row(
                children: [
                  const Expanded(child: Text("Send an Email")),
                  Styling.contentMediumSpacing,
                  Icon(
                    Icons.mail_rounded,
                    size: 24,
                    color: Theme.of(universalContext).primaryColor,
                  ),
                ],
              ),
              onTap: () {
                launchUrlFuture('mailto:howard8479@gmail.com');
              },
            ),
            Styling.contentSmallSpacing,
            HoverEffect(
              backGroundColor: Apptheme.prime100,
              child: Row(
                children: [
                  const Expanded(child: Text("Connect on LinkedIn")),
                  Styling.contentMediumSpacing,
                  Icon(
                    FontAwesomeIcons.linkedinIn,
                    size: 24,
                    color: Theme.of(universalContext).primaryColor,
                  ),
                ],
              ),
              onTap: () {
                launchUrlFuture('https://www.linkedin.com/in/howard-h-chen/');
              },
            ),
            Styling.contentSmallSpacing,
            HoverEffect(
              backGroundColor: Apptheme.prime100,
              child: Row(
                children: [
                  const Expanded(child: Text("My Medium Articles")),
                  Styling.contentMediumSpacing,
                  Icon(
                    FontAwesomeIcons.medium,
                    size: 24,
                    color: Theme.of(universalContext).primaryColor,
                  ),
                ],
              ),
              onTap: () {
                launchUrlFuture('https://medium.com/@Howard_C');
              },
            ),
          ],
        ),
      ),
    );
  }

  static Widget profile(BuildContext context, bool condensed) {
    return Container(
      height: condensed ? null : 340,
      width: !condensed
          ? MediaQuery.of(context).size.width * 0.3
          : double.infinity,
      child: Styling.defaultPaper(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(FontAwesomeIcons.idCard),
                Styling.contentMediumSpacing,
                const Expanded(
                  child: Text(
                    'Short Bio',
                    style: Apptheme.titleMedium,
                  ),
                ),
              ],
            ),
            Styling.contentMediumSpacing,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Howard Chen',
                        style: Apptheme.labelLarge,
                      ),
                      Styling.contentSmallSpacing,
                      const Text(
                        'Serivce designer, Product designer / Full-stack design',
                        style: Apptheme.bodyLarge,
                      ),
                      Styling.contentSmallSpacing,
                      const Text(
                        'currently @ BCG X',
                        style: Apptheme.bodyLarge,
                      ),
                      Styling.contentSmallSpacing,
                      const Text(
                        'Based in: London, UK',
                        style: Apptheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: AspectRatio(
                      aspectRatio: 1 / 1,
                      child: Image.asset('profile_picture.jpg',
                          fit: BoxFit.fitHeight)),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Styling.pageFrame(
      bannerChild: Column(
        children: [
          Styling.contentLargeSpacing,
          HoverEffect(
            onTap: () {
              navigateToLockedHome(context);
            },
            transparentBackground: true,
            child: const Row(
              children: [
                Icon(Icons.arrow_back),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Back to home",
                  style: Apptheme.titleSmall,
                ),
              ],
            ),
          ),
          Styling.contentSmallSpacing,
          RichText(
              text: TextSpan(children: <TextSpan>[
            TextSpan(
                text: "Hi! I am Howard, \n",
                style: Apptheme.headlineLarge
                    .copyWith(color: Theme.of(context).primaryColorLight)),
            TextSpan(
                text: "A designer, book lover, a guitarist a badminton lover ",
                style: Apptheme.headlineLarge.copyWith(
                    fontWeight: FontWeight.w900,
                    color: Theme.of(context).primaryColor)),
            TextSpan(
                text: "fascinated by cultures and curious about all things .",
                style: Apptheme.headlineLarge
                    .copyWith(color: Theme.of(context).primaryColorLight)),
          ])),
          Styling.contentLargeSpacing,
        ],
      ),
      secondChild: Wrap(
        alignment: WrapAlignment.center,
        runSpacing: Styling.defaultSpacing,
        spacing: Styling.defaultSpacing,
        children: [
          profile(context, !deviceIsDesktop),
          _myInterests(context, !deviceIsDesktop),
          _myTools(context, !deviceIsDesktop),
          _contactMe(context, !deviceIsDesktop),
          _bookExchange(context, !deviceIsDesktop),
        ],
      ),
    );
  }
}

class SecretPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SecretPageState();
}

class _SecretPageState extends State<SecretPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance.collection('Books_I_Read').get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return Styling.pageFrame(
              child: HoverEffect(
                  onTap: () {
                    for (int i = 0; i < snapshot.data!.docs.length; i++) {
                      FirebaseFirestore.instance
                          .collection('Books_I_Read')
                          .doc(snapshot.data!.docs[i]['bookName'])
                          .set({
                        "bookName": snapshot.data!.docs[i]['bookName'],
                        "bookID": snapshot.data!.docs[i]['bookID'],
                        "reason": "",
                        "reasonIsASecret": false,
                        "isRecommended": false,
                        "recommendedBy": "",
                        "contact": "",
                        "addedBy":
                            "${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}${DateTime.now().second}${DateTime.now().minute}",
                      });
                    }
                  },
                  child: Text('Update book list')));
        });
  }
}
