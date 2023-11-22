import 'package:flutter/material.dart';
import 'package:howard_chen_portfolio/app_theme.dart';
import 'class.dart';
import 'json_parse.dart';
import 'network.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:url_launcher/url_launcher.dart';
import 'firebase_options.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
      darkTheme: Apptheme.dark(),
//      darkTheme: getAppTheme(context, true),
      themeMode: ThemeMode.system,
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

  void closeExpansionTiles(int pageValue, int projectValue) {
    for (var i = 0; i < widget.jsonContent.projectList.length; i++) {
      if (i != projectValue && deviceIsDesktop == true) {
        controller[i].collapse();
      }
    }
    if (pageValue == 2) {
      controller[projectValue].expand();
    }
  }

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
          closeExpansionTiles(_selectedPageIndex, _selectedProjectIndex + 1);
          setSelectionState(LinkAddress(
              active: true,
              page: _selectedPageIndex,
              project: _selectedProjectIndex + 1,
              challenge: -1));
        } else {
          closeExpansionTiles(_selectedPageIndex, _selectedProjectIndex);
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

    setState(() {
      projectKey = GlobalKey();
    });
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
          if (deviceIsDesktop == true) {
            closeExpansionTiles(_selectedPageIndex, _selectedProjectIndex - 1);
          }
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

  Widget quickLinks(bool deviceIsDesktop) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          clipBehavior: Clip.hardEdge,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              border: Border.all(
                  width: 1, color: Theme.of(context).primaryColorDark),
              borderRadius: const BorderRadius.all(Radius.circular(5))),
          child: deviceIsDesktop
              ? Column(
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
                      height: 8,
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
                        _launchUrl(
                            'https://www.linkedin.com/in/howard-h-chen/');
                      },
                    ),
                  ],
                )
              : Row(
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
                        _launchUrl(
                            'https://www.linkedin.com/in/howard-h-chen/');
                      },
                    ),
                  ],
                ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.15,
        ),
      ],
    );
  }

  Widget sideNavigationPanel() {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NavigationItem(
                buttonName: "Introduction",
                isChallenge: false,
                isSelected: (_selectedPageIndex == 0),
                onCountSelected: () {
                  setSelectionState(LinkAddress(
                      active: true, page: 0, project: 0, challenge: 0));
                }),
            NavigationItem(
                buttonName: "Experience(Under maintenance)",
                isChallenge: false,
                isSelected: (_selectedPageIndex == 1),
                onCountSelected: () {
                  setSelectionState(LinkAddress(
                      active: true, page: 0, project: 0, challenge: 0));
                }),
            const SizedBox(
              height: 8,
            ),
            projectNavigation(),
            smallProjectNavigation(),
          ],
        ),
      ),
    );
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
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.jsonContent.projectList.length,
        itemBuilder: (BuildContext context, int projectIndex) {
          return ExpansionTile(
            tilePadding: const EdgeInsets.symmetric(horizontal: 8),
            controller: controller[projectIndex],
            title: Text(
                style: Apptheme.titleSmall,
                'Project ${projectIndex + 1}, ${widget.jsonContent.projectList[projectIndex].projectTitle}'),
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NavigationItem(
                  buttonName: "Summary",
                  isChallenge: false,
                  isSelected: (_selectedPageIndex == 2 &&
                          projectIndex == _selectedProjectIndex &&
                          _selectedChallengeIndex == -1)
                      ? true
                      : false,
                  onCountSelected: () {
                    closeExpansionTiles(2, projectIndex);
                    setSelectionState(LinkAddress(
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
                        isSelected: (_selectedPageIndex == 2 &&
                                projectIndex == _selectedProjectIndex &&
                                challengeIndex == _selectedChallengeIndex)
                            ? true
                            : false,
                        onCountSelected: () {
                          closeExpansionTiles(2, projectIndex);
                          setSelectionState(LinkAddress(
                              active: true,
                              page: 2,
                              project: projectIndex,
                              challenge: challengeIndex));
                        });
                  }),
              NavigationItem(
                  buttonName: "Impact",
                  isChallenge: false,
                  isSelected: (_selectedPageIndex == 2 &&
                          projectIndex == _selectedProjectIndex &&
                          _selectedChallengeIndex ==
                              widget.jsonContent.projectList[projectIndex]
                                  .challengeContent.length)
                      ? true
                      : false,
                  onCountSelected: () {
                    setSelectionState(LinkAddress(
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
        });
  }

  Widget smallProjectNavigation() {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.jsonContent.smallProjectList.length,
        itemBuilder: (BuildContext context, int projectIndex) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NavigationItem(
                  buttonName:
                      'Other: ${widget.jsonContent.smallProjectList[projectIndex].projectTitle}',
                  isChallenge: false,
                  isSelected: (_selectedPageIndex == 3 &&
                          projectIndex == _selectedProjectIndex)
                      ? true
                      : false,
                  onCountSelected: () {
                    closeExpansionTiles(3, -1);
                    setSelectionState(LinkAddress(
                        active: true,
                        page: 3,
                        project: projectIndex,
                        challenge: 0));
                  }),
            ],
          );
        });
  }

  Widget getContent() {
    if (_selectedPageIndex == 0) {
      return MainPageWelcome(
          jsonContent: widget.jsonContent,
          navigateToProjects: (LinkAddress value) {
            if (deviceIsDesktop == true) {
              closeExpansionTiles(value.page, value.project);
            }
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
          content: widget.jsonContent.smallProjectList);
    } else {
      return const Align(
          alignment: Alignment.center,
          child: SizedBox(
            child: Text('failed to load'),
          ));
    }
  }

  Widget desktopLayout() {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1400),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                width: 32,
              ),
              Expanded(flex: 2, child: sideNavigationPanel()),
              const SizedBox(
                width: 24,
              ),
              Expanded(
                flex: 5,
                child: ContentColumnFrame(
                  key: projectKey,
                  bottomNavigationActive:
                      _selectedPageIndex == 3 || _selectedPageIndex == 2,
                  deviceIsDesktop: deviceIsDesktop,
                  widget: getContent(),
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
              Flexible(flex: 2, child: quickLinks(deviceIsDesktop)),
              const SizedBox(
                width: 32,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget mobileLayout() {
    return Scaffold(
      drawer: Drawer(
        surfaceTintColor: Apptheme.noColor,
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: ListView(
            padding: const EdgeInsets.all(8),
            children: <Widget>[
              sideNavigationPanel(),
              const SizedBox(
                height: 16,
              ),
              quickLinks(deviceIsDesktop)
            ],
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
                child: ContentColumnFrame(
                    key: projectKey,
                    bottomNavigationActive:
                        _selectedPageIndex == 3 || _selectedPageIndex == 2,
                    deviceIsDesktop: deviceIsDesktop,
                    widget: getContent(),
                    navigation: BottomNavigation(
                      previousPage: setPreviousPage,
                      nextPage: setNextPage,
                      nextPageSummary: nextPageSummary(),
                    )),
              ),
              const SizedBox(
                width: 16,
              ),
            ],
          ),
        ),
      ),
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

Future<void> _launchUrl(String webpagelink) async {
  if (!await launchUrl(Uri.parse(webpagelink))) {
    throw Exception(webpagelink);
  }
}
