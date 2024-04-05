import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:howard_chen_portfolio/widgets/password_protection.dart';
import 'package:howard_chen_portfolio/widgets/utility_widgets.dart';
import '../style/app_theme.dart';
import '../main.dart';
import '../functions/network.dart';
import '../widgets/navigation.dart';
import 'book_recommendation.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Styling.topBottomSpacing,
          Container(
            constraints: const BoxConstraints(maxWidth: 1400),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Styling.horizontalPadding,
                Expanded(
                  child: RichText(
                      text: TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: "Hi! I am Howard, \n",
                        style: Apptheme.headlineLarge.copyWith(
                            color: Theme.of(context).primaryColorLight)),
                    TextSpan(
                        text: "A Product / UX / UI Designer ",
                        style: Apptheme.headlineLarge.copyWith(
                            fontWeight: FontWeight.w900,
                            color: Theme.of(context).primaryColor)),
                    TextSpan(
                        text:
                            "experienced in owning the whole of design process with tracked record of strong delivery at pace",
                        style: Apptheme.headlineLarge.copyWith(
                            color: Theme.of(context).primaryColorLight)),
                  ])),
                ),
                deviceIsDesktop ? Styling.horizontalPadding : const SizedBox(),
                Container(
                    constraints: const BoxConstraints(maxWidth: 360),
                    child: deviceIsDesktop
                        ? const QuickLinks()
                        : const SizedBox()),
                Styling.horizontalPadding,
              ],
            ),
          ),
          Styling.contentLargeSpacing,
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.70,
            child: const Carousel(),
          ),
          Styling.contentLargeSpacing,
          Container(
            constraints: const BoxConstraints(maxWidth: 700),
            child: Row(
              children: [
                Styling.horizontalPadding,
                Expanded(
                  child: Styling.largePaper(
                    child: Column(
                      children: [
                        const ParagraphLayout(
                          layoutType: "column",
                          titleTextDisplay: true,
                          titleText:
                          'This is a self-made website powered by flutter and firebase',
                          subtitleText: "",
                          contentText:
                          'The portfolio itself is also a demonstration of my approach to product builds. The ability to carried out coding projects like this greatly helped my design delivery capability and communication with engineers. \n\nIf you are a design student looking for free portfolio solutions, or are just simply interesting in the tech set up please do reach out.',
                          imageLink: 'images/Coding.png',
                        ).layoutSelector(),
                        Styling.dividerLargeSpacing,
                        const BookExchangeIntroduction(),
                      ],
                    ),
                  ),
                ),
                Styling.horizontalPadding,
              ],
            ),
          ),
          Styling.contentLargeSpacing,
          const Footer(),
        ],
      ),
    );
  }
}

class AnimatedGradient extends StatefulWidget {
  const AnimatedGradient({super.key});

  @override
  State<AnimatedGradient> createState() => _AnimatedGradientState();
}

class _AnimatedGradientState extends State<AnimatedGradient> {
  List<Color> colorList = [
    const Color(0xFFF9DEB7),
    const Color(0xFFC480B1),
    const Color(0xFF0EA8E4),
  ];
  List<Alignment> alignmentList = [
    Alignment.bottomLeft,
    Alignment.bottomRight,
    Alignment.topRight,
    Alignment.topLeft,
  ];
  int index = 0;
  Color bottomColor = Apptheme.prime100;
  Color topColor = Apptheme.prime500;
  Alignment begin = Alignment.bottomLeft;
  Alignment end = Alignment.topRight;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        bottomColor = Apptheme.prime500;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        AnimatedContainer(
          duration: const Duration(seconds: 2),
          onEnd: () {
            setState(() {
              index = index + 1;
              bottomColor = colorList[index % colorList.length];
              topColor = colorList[(index + 1) % colorList.length];
            });
          },
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: begin,
            end: end,
            colors: [bottomColor, topColor],
          )),
        ),
      ],
    ));
  }
}

class Carousel extends StatefulWidget {
  const Carousel({super.key});

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  late PageController _pageController;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
        viewportFraction: deviceIsDesktop ? 0.3 : 1, initialPage: 5);
    _timer = Timer.periodic(
        const Duration(seconds: 10),
        (Timer t) => _pageController.nextPage(
            duration: const Duration(milliseconds: 500), curve: Curves.easeIn));
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            allowImplicitScrolling: true,
            itemBuilder: (BuildContext context, int projectIndex) {
              return PreviewItem(
                projectThumbnail: jsonContent
                    .smallProjectList[projectIndex % 5].projectThumbnail,
                projectVideoPreview: jsonContent
                    .smallProjectList[projectIndex % 5].projectVideoPreview,
                projectTitle:
                    jsonContent.smallProjectList[projectIndex % 5].projectTitle,
                projectTopic:
                    jsonContent.smallProjectList[projectIndex % 5].projectTopic,
                projectIndex: projectIndex % 5,
              );
            }),
        Align(
          alignment: Alignment.centerLeft,
          child: HoverEffect(
            transparentBackground: true,
            onTap: () {
              _pageController.previousPage(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeIn);
            },
            child: Icon(
              Icons.arrow_back_ios_new,
              size: 48,
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: HoverEffect(
            onTap: () {
              _pageController.nextPage(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeIn);
            },
            transparentBackground: true,
            child: Icon(
              Icons.arrow_forward_ios,
              size: 48,
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
        ),
      ],
    );
  }
}

class PreviewItem extends StatelessWidget {
  const PreviewItem(
      {super.key,
      required this.projectThumbnail,
      required this.projectVideoPreview,
      required this.projectTitle,
      required this.projectTopic,
      required this.projectIndex});

  final String projectThumbnail;
  final String projectVideoPreview;
  final String projectTitle;
  final String projectTopic;
  final int projectIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Stack(
        children: <Widget>[
          VideoPlayerScreen(projectVideoPreview),
          Align(
            alignment: Alignment.center,
            child: HoverEffect(
              onTap: () {
                if (unlocked == true) {
                  navigateBetweenProjects(context, projectIndex);
                } else {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const AlertDialog(
                          title:
                              Text('Enter Password to View Protected Content'),
                          content: UnlockButton(isDialog: true),
                        );
                      });
                }
              },
              transparentBackground: false,
              child: Container(
                decoration: Styling.defaultState,
                constraints: const BoxConstraints(maxWidth: 320),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FirebaseFutureImageBuilder(projectThumbnail),
                    Styling.contentSmallSpacing,
                    Text(style: Apptheme.titleMedium, projectTitle),
                    Styling.contentSmallSpacing,
                    Text(style: Apptheme.labelMedium, 'Topics: $projectTopic'),
                    Styling.contentSmallSpacing,
                    unlocked
                        ? const SizedBox()
                        : Row(
                            children: [
                              const Icon(FontAwesomeIcons.lock),
                              Styling.contentMediumSpacing,
                              const Expanded(
                                  child: Text(
                                      style: Apptheme.labelSmall,
                                      'Enter password to view content')),
                            ],
                          ),
                    Styling.contentSmallSpacing,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NavigationShell extends StatefulWidget {
  const NavigationShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<NavigationShell> createState() => _NavigationShellState();
}

class _NavigationShellState extends State<NavigationShell> {
  Key projectKey = GlobalKey();

  Scaffold desktopScaffold(StatefulNavigationShell navigationShell) {
    return Scaffold(backgroundColor: Apptheme.noColor, body: navigationShell);
  }

  Scaffold mobileScaffold(StatefulNavigationShell navigationShell) {
    return Scaffold(
      backgroundColor: Apptheme.noColor,
      drawer: Drawer(
        surfaceTintColor: Apptheme.noColor,
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: Center(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(8),
              children: const <Widget>[
                NavigationPanel(currentProjects: 0),
                SizedBox(
                  height: 16,
                ),
                QuickLinks(
                  highContrast: false,
                )
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
          bottom: const PreferredSize(
        preferredSize: Size.fromHeight(1),
        child: Divider(height: 1),
      )),
      body: navigationShell,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      deviceIsDesktop = constraints.maxWidth > 800;
      return Stack(
        children: [
          const AnimatedGradient(),
          deviceIsDesktop
              ? desktopScaffold(widget.navigationShell)
              : mobileScaffold(widget.navigationShell)
        ],
      );
    });
  }
}
