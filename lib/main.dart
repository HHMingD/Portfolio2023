import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:howard_chen_portfolio/app_theme.dart';
import 'class.dart';
import 'json_parse.dart';
import 'network.dart';
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:url_launcher/url_launcher.dart';
import 'firebase_options.dart';

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
      theme: Apptheme.themeData,
      darkTheme: Apptheme.themeData.copyWith(
        colorScheme: ColorScheme.fromSeed(seedColor: Apptheme.black),
        scaffoldBackgroundColor: Apptheme.black,
        iconTheme: const IconThemeData(color: Apptheme.white),
        textTheme: Apptheme.textTheme.copyWith(
          headlineLarge: Apptheme.headlineLarge.copyWith(color: Apptheme.white),
          headlineMedium: Apptheme.headlineMedium.copyWith(color: Apptheme.white),
          headlineSmall: Apptheme.headlineSmall.copyWith(color: Apptheme.white),
          titleLarge: Apptheme.titleLarge.copyWith(color: Apptheme.white),
          titleMedium: Apptheme.titleMedium.copyWith(color: Apptheme.white),
          titleSmall: Apptheme.titleSmall.copyWith(color: Apptheme.white),
          bodyLarge: Apptheme.bodyLarge.copyWith(color: Apptheme.white),
          bodyMedium: Apptheme.bodyMedium.copyWith(color: Apptheme.white),
        ),
      ),
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

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  Key projectKey = GlobalKey();
  int _selectedPageIndex = 0;

  // 0 = Introduction, 1 = Experience, 2 = Projects, 3 = Small Projects
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

  void setSelectionState(
      int setPageIndex, int setProjectIndex, int setChallengeIndex) {
    {
      setState(() {
        projectKey = GlobalKey();
        _selectedPageIndex = setPageIndex;
        _selectedProjectIndex = setProjectIndex;
        _selectedChallengeIndex = setChallengeIndex;
      });
    }
  }

  nextPageSummary<String>() {
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
  }

  void setNextPage() {
    setState(() {
      projectKey = GlobalKey();

      if (_selectedChallengeIndex <
          widget.jsonContent.projectList[_selectedProjectIndex].challengeContent
              .length) {
        _selectedChallengeIndex = _selectedChallengeIndex + 1;
      } else {
        if (_selectedProjectIndex < widget.jsonContent.projectList.length - 1) {
          if (deviceIsDesktop == true) {
            controller[_selectedProjectIndex].collapse();
            controller[_selectedProjectIndex + 1].expand();
          }
          _selectedChallengeIndex = -1;
          _selectedProjectIndex = _selectedProjectIndex + 1;
        } else {
          if (deviceIsDesktop == true) {
            controller[_selectedProjectIndex].collapse();
          }
          _selectedPageIndex = 0;
          _selectedProjectIndex = 0;
          _selectedChallengeIndex = 0;
        }
      }
    });
  }

  void setPreviousPage() {
    setState(() {
      projectKey = GlobalKey();
      if (_selectedChallengeIndex > 0) {
        _selectedChallengeIndex = _selectedChallengeIndex - 1;
      } else {
        if (_selectedProjectIndex > 0) {
          if (deviceIsDesktop == true) {
            controller[_selectedProjectIndex].collapse();
            controller[_selectedProjectIndex - 1].expand();
          }
          _selectedChallengeIndex = -1;
          _selectedProjectIndex = _selectedProjectIndex - 1;
        } else {
          if (deviceIsDesktop == true) {
            controller[_selectedProjectIndex].collapse();
          }
          _selectedPageIndex = 0;
          _selectedProjectIndex = 0;
          _selectedChallengeIndex = 0;
        }
      }
    });
  }

  Widget quickLinks(bool deviceIsDesktop) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          clipBehavior: Clip.hardEdge,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              border: Border.all(width: 1),
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
                          child: const Image(
                            image: AssetImage('linkedin_logo60px.png'),
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
                          child: const Image(
                            image: AssetImage('linkedin_logo60px.png'),
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
                  setSelectionState(0, 0, 0);
                }),
            NavigationItem(
                buttonName: "Experience(Under maintenance)",
                isChallenge: false,
                isSelected: (_selectedPageIndex == 1),
                onCountSelected: () {
                  setSelectionState(0, 0, 0);
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
                    setSelectionState(2, projectIndex, -1);
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
                          setSelectionState(2, projectIndex, challengeIndex);
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
                    setSelectionState(
                        2,
                        projectIndex,
                        widget.jsonContent.projectList[projectIndex]
                            .challengeContent.length);
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
                    setSelectionState(3, projectIndex, 0);
                  }),
            ],
          );
        });
  }

  Widget getContent() {
    if (_selectedPageIndex == 0) {
      return MainPageWelcome(
          key: projectKey,
          deviceIsDesktop: deviceIsDesktop,
          jsonContent: widget.jsonContent,
          navigateToProjects: (LinkAddress value) {
            if (deviceIsDesktop == true) {
              closeExpansionTiles(value.page, value.project);
            }
            setSelectionState(value.page, value.project, value.challenge);
          });
    }
    if (_selectedPageIndex == 2) {
      return MainPageProjectContent(
        key: projectKey,
        deviceIsDesktop: deviceIsDesktop,
        selectionProjectIndex: _selectedProjectIndex,
        selectionChallengeIndex: _selectedChallengeIndex,
        content: widget.jsonContent.projectList,
        previousPage: setPreviousPage,
        nextPage: setNextPage,
        nextpageSummary: nextPageSummary(),
        navigateToProjects: (LinkAddress value) {
          setSelectionState(
            value.page,
            value.project,
            value.challenge,
          );
        },
      );
    }
    if (_selectedPageIndex == 3) {
      return MainPageSideProjectContent(
          key: projectKey,
          deviceIsDesktop: deviceIsDesktop,
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
                child: getContent(),
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
        surfaceTintColor: Apptheme.noColor,
        backgroundColor: Apptheme.white,
      ),
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
                child: getContent(),
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
