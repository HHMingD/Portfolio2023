import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:howard_chen_portfolio/app_theme.dart';
import 'class.dart';
import 'json_parse.dart';
import 'network.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:url_launcher/url_launcher.dart';
import 'firebase_options.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

FirebaseAnalytics analytics = FirebaseAnalytics.instance;

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Howard Chen Portfolio',
      theme: Apptheme.light(),
//      darkTheme: Apptheme.dark(),
//      darkTheme: getAppTheme(context, true),
//      themeMode: ThemeMode.system,
      home: const FetchData(),
    );
  }
}

class FetchData extends StatefulWidget {
  const FetchData({super.key});

  @override
  State<StatefulWidget> createState() => _FetchDataState();
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
    return FutureBuilder(
        future: myFuture,
        builder: (BuildContext context, AsyncSnapshot<JsonStructure> snapshot) {
          if (snapshot.hasData) {
            return MyHomePage(jsonContent: snapshot.data!);
          } else {
            return const Align(
                alignment: Alignment.center,
                child: SizedBox(
                    height: 50, width: 50, child: CircularProgressIndicator()));
          }
        });
  }
}

class QuickLinks extends StatelessWidget {
  const QuickLinks({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Wrap(
          children: <Widget>[
            InkWell(
              child: Container(
                  padding: const EdgeInsets.all(12),
                  child: const Icon(
                    Icons.mail_rounded,
                    size: 24,
                  )),
              onTap: () {
                _launchUrl('mailto:howard8479@gmail.com');
              },
            ),
            const SizedBox(
              width: 8,
            ),
            InkWell(
              child: Container(
                  width: 48,
                  height: 48,
                  padding: const EdgeInsets.all(12),
                  child: const Icon(
                    FontAwesomeIcons.linkedinIn,
                    size: 24,
                  )),
              onTap: () {
                _launchUrl('https://www.linkedin.com/in/howard-h-chen/');
              },
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.15,
        ),
      ],
    );
  }
}

class NavigationPanel extends StatefulWidget {
  const NavigationPanel({
    super.key,
    required this.jsonContent,
    required this.linkAdress,
    required this.navigateToProjects,
  });

  final JsonStructure jsonContent;
  final LinkAddress linkAdress;
  final ValueSetter<LinkAddress> navigateToProjects;

  @override
  State<NavigationPanel> createState() => _NavigationPanelState();
}

class _NavigationPanelState extends State<NavigationPanel> {
  bool selected = false;
  void closeExpansionTiles(int pageValue, int projectValue) {
    for (var i = 0; i < widget.jsonContent.projectList.length; i++) {
      if (i != projectValue) {
        controller[i].collapse();
      }
    }
    if (pageValue == 2) {
      controller[projectValue].expand();
    }
  }

  List<ExpansionTileController> controller = [];

  @override
  void initState() {
    for (var i = 0; i < widget.jsonContent.projectList.length; i++) {
      controller.add(ExpansionTileController());
    }
    super.initState();
  }
  Widget projectNavigation() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
          childCount: widget.jsonContent.projectList.length,
          (BuildContext context, int projectIndex) {
        return ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 8),
          title: Text(
              style: Apptheme.labelMedium,
              widget.jsonContent.projectList[projectIndex].projectTitle),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NavigationItem(
                buttonName: "Summary",
                isChallenge: true,
                isSelected: (widget.linkAdress.page == 2 &&
                        projectIndex == widget.linkAdress.project &&
                        widget.linkAdress.challenge == -1)
                    ? true
                    : false,
                onCountSelected: () {
                  widget.navigateToProjects(LinkAddress(
                      active: true,
                      page: 2,
                      project: projectIndex,
                      challenge: -1));

                }),
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.jsonContent.projectList[projectIndex]
                    .challengeContent.length,
                itemBuilder: (BuildContext context, int challengeIndex) {
                  return NavigationItem(
                      buttonName: widget.jsonContent.projectList[projectIndex]
                          .challengeContent[challengeIndex].STARTitle,
                      isChallenge: true,
                      isSelected: (widget.linkAdress.page == 2 &&
                              projectIndex == widget.linkAdress.project &&
                              challengeIndex == widget.linkAdress.challenge)
                          ? true
                          : false,
                      onCountSelected: () {
                        widget.navigateToProjects(LinkAddress(
                            active: true,
                            page: 2,
                            project: projectIndex,
                            challenge: challengeIndex));

                      });
                }),
            NavigationItem(
                buttonName: "Impact",
                isChallenge: true,
                isSelected: (widget.linkAdress.page == 2 &&
                        projectIndex == widget.linkAdress.project &&
                        widget.linkAdress.challenge ==
                            widget.jsonContent.projectList[projectIndex]
                                .challengeContent.length)
                    ? true
                    : false,
                onCountSelected: () {
                  widget.navigateToProjects(LinkAddress(
                      active: true,
                      page: 2,
                      project: projectIndex,
                      challenge: widget.jsonContent.projectList[projectIndex]
                          .challengeContent.length));

                }),
            const SizedBox(
              height: 16,
            ),
          ],
        );
      }),
    );
  }

  Widget smallProjectNavigation() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
          childCount: widget.jsonContent.smallProjectList.length,
          (BuildContext context, int projectIndex) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NavigationItem(
                buttonName: widget
                    .jsonContent.smallProjectList[projectIndex].projectTitle,
                isChallenge: false,
                isSelected: (widget.linkAdress.page == 3 &&
                        projectIndex == widget.linkAdress.project)
                    ? true
                    : false,
                onCountSelected: () {
                  widget.navigateToProjects(LinkAddress(
                      active: true,
                      page: 3,
                      project: projectIndex,
                      challenge: 0));
                }),
          ],
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Apptheme.defaultState
          .copyWith(borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.all(8),
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: CustomScrollView(
          shrinkWrap: true,
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Text(
                  'All projects:',
                  style: Apptheme.titleSmall
                      .copyWith(color: Theme.of(context).primaryColorDark),
                ),
              ),
            ),
            projectNavigation(),
            smallProjectNavigation(),
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.jsonContent});

  final JsonStructure jsonContent;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Key projectKey = GlobalKey();

  // 0 = Introduction, 1 = Experience, 2 = Projects, 3 = Small Projects

  int _selectedPageIndex = 0;
  int _selectedProjectIndex = 0;
  int _selectedChallengeIndex = 0;
  late bool deviceIsDesktop;

  void setSelectionState(LinkAddress address) {
    {
      setState(() {
        projectKey = GlobalKey();
        _selectedPageIndex = address.page;
        _selectedProjectIndex = address.project;
        _selectedChallengeIndex = address.challenge;
      });
    }
  }

  nextPageSummary<String>() {
    if (_selectedPageIndex == 2) {
      if (_selectedChallengeIndex <
          widget.jsonContent.projectList[_selectedProjectIndex].challengeContent
                  .length -
              1) {
        return "Next up: ${widget.jsonContent.projectList[_selectedProjectIndex].challengeContent[_selectedChallengeIndex + 1].STARTitle}";
      }
      if (_selectedChallengeIndex ==
          widget.jsonContent.projectList[_selectedProjectIndex].challengeContent
                  .length -
              1) {
        return "Next up: Project Impact";
      }
      if (_selectedChallengeIndex ==
              widget.jsonContent.projectList[_selectedProjectIndex]
                  .challengeContent.length &&
          _selectedProjectIndex < widget.jsonContent.projectList.length - 1) {
        return "Next Project";
      } else {
        return "Back to summary";
      }
    } else {
      if (_selectedPageIndex == 3 &&
          _selectedProjectIndex <
              widget.jsonContent.smallProjectList.length - 1) {
        return "Next up: ${widget.jsonContent.smallProjectList[_selectedProjectIndex + 1].projectTitle} ";
      } else {
        return "Back to summary";
      }
    }
  }

  void setNextPage() {
    if (_selectedPageIndex == 2) {
      if (_selectedChallengeIndex <
          widget.jsonContent.projectList[_selectedProjectIndex].challengeContent
              .length) {
        setSelectionState(LinkAddress(
            active: true,
            page: _selectedPageIndex,
            project: _selectedProjectIndex,
            challenge: _selectedChallengeIndex + 1));
      } else {
        if (_selectedProjectIndex < widget.jsonContent.projectList.length - 1) {
          setSelectionState(LinkAddress(
              active: true,
              page: _selectedPageIndex,
              project: _selectedProjectIndex + 1,
              challenge: -1));
        } else {
          setSelectionState(
              LinkAddress(active: true, page: 0, project: 0, challenge: 0));
        }
      }
    }
    if (_selectedPageIndex == 3) {
      if (_selectedProjectIndex <
          widget.jsonContent.smallProjectList.length - 1) {
        setSelectionState(LinkAddress(
            active: true,
            page: _selectedPageIndex,
            project: _selectedProjectIndex + 1,
            challenge: -1));
      } else {
        setSelectionState(
            LinkAddress(active: true, page: 0, project: 0, challenge: 0));
      }
    } else {
      print('Navigation value incorrect');
    }
  }

  void setPreviousPage() {
    if (_selectedPageIndex == 2) {
      if (_selectedChallengeIndex > -1) {
        setSelectionState(LinkAddress(
            active: true,
            page: _selectedPageIndex,
            project: _selectedProjectIndex,
            challenge: _selectedChallengeIndex - 1));
      } else {
        if (_selectedProjectIndex > 0) {
          setSelectionState(LinkAddress(
              active: true,
              page: _selectedPageIndex,
              project: _selectedProjectIndex - 1,
              challenge: -1));
        } else {
          setSelectionState(
              LinkAddress(active: true, page: 0, project: 0, challenge: 0));
        }
      }
    }
    if (_selectedPageIndex == 3) {
      if (_selectedProjectIndex > 0) {
        setSelectionState(LinkAddress(
            active: true,
            page: _selectedPageIndex,
            project: _selectedProjectIndex - 1,
            challenge: -1));
      } else {
        setSelectionState(
            LinkAddress(active: true, page: 0, project: 0, challenge: 0));
      }
    } else {
      print('Navigation value incorrect');
    }
  }

  Widget getContent() {
    if (_selectedPageIndex == 0) {
      return MainPageWelcome(
          jsonContent: widget.jsonContent,
          navigateToProjects: (LinkAddress value) {
            setSelectionState(value);
          });
    }
    if (_selectedPageIndex == 2) {
      return MainPageProjectContent(
        selectionProjectIndex: _selectedProjectIndex,
        selectionChallengeIndex: _selectedChallengeIndex,
        content: widget.jsonContent.projectList,
        navigateToProjects: (LinkAddress value) {
          setSelectionState(value);
        },
      );
    }
    if (_selectedPageIndex == 3) {
      return MainPageSideProjectContent(
        selectionProjectIndex: _selectedProjectIndex,
        content: widget.jsonContent.smallProjectList,
        navigateToProjects: (LinkAddress value) {
          setSelectionState(value);
        },
      );
    } else {
      return const Align(
          alignment: Alignment.center,
          child: SizedBox(
            child: Text('failed to load'),
          ));
    }
  }

  Widget desktopLayout() {
    return Stack(
      children: [
        const AnimatedGradient(),
        Scaffold(
          backgroundColor: Apptheme.noColor,
          body: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 1600),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    width: 32,
                  ),
                  Expanded(
                      flex: 2,
                      child: _selectedPageIndex != 0
                          ? NavigationPanel(
                              jsonContent: widget.jsonContent,
                              linkAdress: LinkAddress(
                                  active: true,
                                  page: _selectedPageIndex,
                                  project: _selectedProjectIndex,
                                  challenge: _selectedChallengeIndex),
                              navigateToProjects: (LinkAddress value) {
                                setSelectionState(value);
                              },
                            )
                          : const SizedBox()),
                  const SizedBox(
                    width: 24,
                  ),
                  Expanded(
                    flex: 5,
                    child: ContentFrame(
                      key: projectKey,
                      bottomNavigationActive:
                          _selectedPageIndex == 3 || _selectedPageIndex == 2,
                      deviceIsDesktop: deviceIsDesktop,
                      contentWidget: getContent(),
                      navigation: BottomNavigation(
                        previousPage: setPreviousPage,
                        nextPage: setNextPage,
                        nextPageSummary: nextPageSummary(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                  const Expanded(flex: 2, child: QuickLinks()),
                  const SizedBox(
                    width: 32,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget mobileLayout() {
    return Stack(
      children: [
        const AnimatedGradient(),
        Scaffold(
          backgroundColor: Apptheme.noColor,
          drawer: Drawer(
            surfaceTintColor: Apptheme.noColor,
            child: ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: Center(
                child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  children: <Widget>[
                    NavigationPanel(
                      jsonContent: widget.jsonContent,
                      linkAdress: LinkAddress(
                          active: true,
                          page: _selectedPageIndex,
                          project: _selectedPageIndex,
                          challenge: _selectedPageIndex),
                      navigateToProjects: (LinkAddress value) {
                        setSelectionState(value);
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const QuickLinks()
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
          body: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 1400),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: ContentFrame(
                      key: projectKey,
                      bottomNavigationActive:
                          _selectedPageIndex == 3 || _selectedPageIndex == 2,
                      deviceIsDesktop: deviceIsDesktop,
                      contentWidget: getContent(),
                      navigation: BottomNavigation(
                        previousPage: setPreviousPage,
                        nextPage: setNextPage,
                        nextPageSummary: nextPageSummary(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      deviceIsDesktop = constraints.maxWidth > 800;
      return deviceIsDesktop ? desktopLayout() : mobileLayout();
    });
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

Future<void> _launchUrl(String webpagelink) async {
  if (!await launchUrl(Uri.parse(webpagelink))) {
    throw Exception(webpagelink);
  }
}
