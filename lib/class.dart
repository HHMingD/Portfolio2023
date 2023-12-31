import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'main.dart';
import 'app_theme.dart';
import 'json_parse.dart';
import 'network.dart';
import 'tools.dart';



class MainPageWelcome extends StatelessWidget {
  const MainPageWelcome(
      {super.key, required this.navigateToProjects, required this.jsonContent});

  final JsonStructure jsonContent;
  final ValueSetter<LinkAddress> navigateToProjects;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.40,
          ),
          Container(
            constraints: const BoxConstraints(maxWidth: 1400),
            child: Row(
              children: [
                const SizedBox(
                  width: 32,
                ),
                Expanded(
                  flex: 3,
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
                const SizedBox(
                  width: 24,
                ),
                const Expanded(
                    flex: 1,
                    child: QuickLinks(
                      verticalLayout: false,
                    )),
                const SizedBox(
                  width: 32,
                )
              ],
            ),
          ),
          const SizedBox(
            height: 48,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.70,
            child: Carousel(
                jsonContent: jsonContent,
                navigateToProjects: navigateToProjects),
          ),
          const SizedBox(height: 48),
          Container(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              children: [
                const Text(
                  'Due to NDA constrains some of the images may not be available. Please feel free to reach out if you are interested in learning more about my work.',
                  style: Apptheme.bodyMedium,
                ),
                const SizedBox(
                  height: 23,
                ),
                const Divider(
                  height: 1,
                ),
                const SizedBox(
                  height: 24,
                ),
//                GetBook(navigateToProjects: (LinkAddress value) {navigateToProjects(value);},),
                ParagraphLayout(
                        layoutType: "column",
                        titleTextDisplay: true,
                        titleText:
                            'This is a self-made website powered by flutter and firebase',
                        subtitleText: "",
                        contentText:
                            'The portfolio itself is also a demonstration of my approach to product builds. The ability to carried out coding projects like this greatly helped my design delivery capability and communication with engineers. \n\nIf you are a design student looking for free portfolio solutions, or are just simply interesting in the tech set up please do reach out.',
                        imageLink: 'images/Coding.png',
                        context: context,
                        linkAddress: LinkAddress(active: false, 0, 0, 0),
                        navigation: (value) {})
                    .layoutSelector(),
                const SizedBox(
                  height: 48,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MainPageProjectContent extends StatelessWidget {
  const MainPageProjectContent({
    super.key,
    required this.selectionProjectIndex,
    required this.selectionChallengeIndex,
    required this.content,
    required this.navigateToProjects,
  });

  final int selectionProjectIndex;
  final int selectionChallengeIndex;
  final List<ProjectContent> content;
  final ValueSetter<LinkAddress> navigateToProjects;

  Widget customExpansionTile(String titleText, String contentText, String label,
      BuildContext context) {
    return ExpansionTile(
      shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      tilePadding: const EdgeInsets.all(8),
      title: RichText(
          text: TextSpan(children: <TextSpan>[
        TextSpan(
            text: "$label \n",
            style: Apptheme.bodyLarge
                .copyWith(color: Theme.of(context).primaryColor)),
        TextSpan(
            text: titleText,
            style: Apptheme.labelMedium
                .copyWith(color: Theme.of(context).primaryColor))
      ])),
      key: GlobalKey(),
      childrenPadding: const EdgeInsets.all(8),
      children: <Widget>[
        SizedBox(
          width: double.infinity,
          child: Text(style: Apptheme.bodyLarge, contentText),
        ),
        const SizedBox(
          height: 15,
        ),
        const Divider(
          height: 1,
        )
      ],
    );
  }

  Widget getContent(BuildContext context) {
    if (selectionChallengeIndex == -1) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
              style: Apptheme.headlineSmall,
              "${content[selectionProjectIndex].projectTitle} Summary"),
          const SizedBox(
            height: 24,
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Theme.of(context).primaryColor)),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                RichText(
                  text: TextSpan(children: [
                    const TextSpan(
                        style: Apptheme.titleSmall, text: "My role:  "),
                    TextSpan(
                        style: Apptheme.bodyLarge,
                        text: content[selectionProjectIndex].projectMyRole),
                  ]),
                ),
                const SizedBox(
                  height: 24,
                ),
                RichText(
                  text: TextSpan(children: [
                    const TextSpan(
                        style: Apptheme.titleSmall, text: "Duration:  "),
                    TextSpan(
                        style: Apptheme.bodyLarge,
                        text: content[selectionProjectIndex].projectDuration),
                  ]),
                ),
                const SizedBox(
                  height: 24,
                ),
                RichText(
                  text: TextSpan(children: [
                    const TextSpan(
                        style: Apptheme.titleSmall, text: "Location:  "),
                    TextSpan(
                        style: Apptheme.bodyLarge,
                        text: content[selectionProjectIndex].projectLocation),
                  ]),
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: RichText(
                        text: TextSpan(children: [
                          const TextSpan(
                              style: Apptheme.titleSmall, text: "Team:  \n"),
                          TextSpan(
                              style: Apptheme.bodyLarge,
                              text: content[selectionProjectIndex]
                                  .teamComposition),
                        ]),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      flex: 1,
                      child: RichText(
                        text: TextSpan(children: [
                          const TextSpan(
                              style: Apptheme.titleSmall, text: "Topic:  \n"),
                          TextSpan(
                              style: Apptheme.bodyLarge,
                              text:
                                  content[selectionProjectIndex].projectTopic),
                        ]),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          const SizedBox(
            height: 24,
          ),
          ColumnBuilder(
              itemCount:
                  content[selectionProjectIndex].summaryContentList.length,
              itemBuilder: (BuildContext context, int paragraphIndex) {
                return Column(
                  children: <Widget>[
                    ParagraphLayout(
                        layoutType: content[selectionProjectIndex]
                            .summaryContentList[paragraphIndex]
                            .layout,
                        titleTextDisplay: true,
                        titleText: content[selectionProjectIndex]
                            .summaryContentList[paragraphIndex]
                            .titleText,
                        subtitleText: content[selectionProjectIndex]
                            .summaryContentList[paragraphIndex]
                            .subtitleText,
                        contentText: content[selectionProjectIndex]
                            .summaryContentList[paragraphIndex]
                            .contentText,
                        imageLink: content[selectionProjectIndex]
                            .summaryContentList[paragraphIndex]
                            .imageLocation,
                        context: context,
                        linkAddress: content[selectionProjectIndex]
                            .summaryContentList[paragraphIndex]
                            .link,
                        navigation: (LinkAddress value) {
                          navigateToProjects(value);
                        }).layoutSelector(),
                    const SizedBox(
                      height: 48,
                    ),
                  ],
                );
              }),
        ],
      );
    }
    if (selectionChallengeIndex ==
        content[selectionProjectIndex].challengeContent.length) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            style: Apptheme.headlineSmall,
            "${content[selectionProjectIndex].projectTitle} Impact",
          ),
          const SizedBox(
            height: 24,
          ),
          ColumnBuilder(
              itemCount:
                  content[selectionProjectIndex].impactContentList.length,
              itemBuilder: (BuildContext context, int paragraphIndex) {
                return Column(
                  children: <Widget>[
                    ParagraphLayout(
                        layoutType: content[selectionProjectIndex]
                            .impactContentList[paragraphIndex]
                            .layout,
                        titleTextDisplay: true,
                        titleText: content[selectionProjectIndex]
                            .impactContentList[paragraphIndex]
                            .titleText,
                        subtitleText: content[selectionProjectIndex]
                            .impactContentList[paragraphIndex]
                            .subtitleText,
                        contentText: content[selectionProjectIndex]
                            .impactContentList[paragraphIndex]
                            .contentText,
                        imageLink: content[selectionProjectIndex]
                            .impactContentList[paragraphIndex]
                            .imageLocation,
                        context: context,
                        linkAddress: content[selectionProjectIndex]
                            .impactContentList[paragraphIndex]
                            .link,
                        navigation: (LinkAddress value) {
                          navigateToProjects(value);
                        }).layoutSelector(),
                    const SizedBox(
                      height: 48,
                    ),
                  ],
                );
              }),
          const SizedBox(
            height: 48,
          ),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RichText(
              text: TextSpan(children: [
            TextSpan(
                style: Apptheme.headlineSmall
                    .copyWith(fontWeight: FontWeight.w500),
                text: "Challenge:\n"),
            TextSpan(
                style: Apptheme.headlineSmall,
                text: content[selectionProjectIndex]
                    .challengeContent[selectionChallengeIndex]
                    .STARTitle)
          ])),
          const SizedBox(
            height: 24,
          ),
          Text(
              style: Apptheme.bodyLarge,
              content[selectionProjectIndex]
                  .challengeContent[selectionChallengeIndex]
                  .challengeSummary),
          const SizedBox(
            height: 11,
          ),
          const Divider(
            height: 1,
          ),
          const SizedBox(
            height: 24,
          ),
          customExpansionTile(
              content[selectionProjectIndex]
                  .challengeContent[selectionChallengeIndex]
                  .situationTitle,
              content[selectionProjectIndex]
                  .challengeContent[selectionChallengeIndex]
                  .situationContent,
              'The Situation: ',
              context),
          const SizedBox(
            height: 16,
          ),
          customExpansionTile(
              content[selectionProjectIndex]
                  .challengeContent[selectionChallengeIndex]
                  .taskTitle,
              content[selectionProjectIndex]
                  .challengeContent[selectionChallengeIndex]
                  .taskContent,
              'The Task: ',
              context),
          const SizedBox(
            height: 16,
          ),
          customExpansionTile(
              content[selectionProjectIndex]
                  .challengeContent[selectionChallengeIndex]
                  .actionTitle,
              content[selectionProjectIndex]
                  .challengeContent[selectionChallengeIndex]
                  .actionContent,
              'The Action: ',
              context),
          const SizedBox(
            height: 16,
          ),
          customExpansionTile(
              content[selectionProjectIndex]
                  .challengeContent[selectionChallengeIndex]
                  .resultTitle,
              content[selectionProjectIndex]
                  .challengeContent[selectionChallengeIndex]
                  .resultContent,
              'The Result: ',
              context),
          const SizedBox(
            height: 24,
          ),
          const Text(style: Apptheme.titleLarge, 'Gallery'),
          const SizedBox(
            height: 24,
          ),
          ColumnBuilder(
              itemCount: content[selectionProjectIndex]
                  .challengeContent[selectionChallengeIndex]
                  .paragraphContentList
                  .length,
              itemBuilder: (BuildContext context, int imageIndex) {
                return Column(
                  children: <Widget>[
                    ParagraphLayout(
                            layoutType: content[selectionProjectIndex]
                                .challengeContent[selectionChallengeIndex]
                                .paragraphContentList[imageIndex]
                                .layout,
                            titleTextDisplay: true,
                            titleText: content[selectionProjectIndex]
                                .challengeContent[selectionChallengeIndex]
                                .paragraphContentList[imageIndex]
                                .titleText,
                            subtitleText: content[selectionProjectIndex]
                                .challengeContent[selectionChallengeIndex]
                                .paragraphContentList[imageIndex]
                                .subtitleText,
                            contentText: content[selectionProjectIndex]
                                .challengeContent[selectionChallengeIndex]
                                .paragraphContentList[imageIndex]
                                .contentText,
                            imageLink: content[selectionProjectIndex]
                                .challengeContent[selectionChallengeIndex]
                                .paragraphContentList[imageIndex]
                                .imageLocation,
                            context: context,
                            linkAddress: content[selectionProjectIndex]
                                .challengeContent[selectionChallengeIndex]
                                .paragraphContentList[imageIndex]
                                .link,
                            navigation: (value) {})
                        .layoutSelector(),
                    const SizedBox(
                      height: 48,
                    ),
                  ],
                );
              }),
          const SizedBox(
            height: 24,
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          constraints: const BoxConstraints(maxWidth: 700),
          decoration: BoxDecoration(
            color: Apptheme.white,
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  navigateToProjects(LinkAddress(0, 0, 0));
                },
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
              const SizedBox(height: 24),
              getContent(context),
            ],
          ),
        ),
      ],
    );
  }
}

class MainPageSideProjectContent extends StatelessWidget {
  const MainPageSideProjectContent({
    super.key,
    required this.selectionProjectIndex,
    required this.content,
    required this.navigateToProjects,
  });

  final int selectionProjectIndex;
  final List<SmallProjectContent> content;
  final ValueSetter<LinkAddress> navigateToProjects;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          constraints: const BoxConstraints(maxWidth: 700),
          decoration: BoxDecoration(
            color: Apptheme.white,
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              InkWell(
                onTap: () {
                  navigateToProjects(LinkAddress(active: true, 0, 0, 0));
                },
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
              const SizedBox(
                height: 24,
              ),
              Text(
                  style: Apptheme.headlineSmall,
                  content[selectionProjectIndex].projectTitle),
              const SizedBox(
                height: 24,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Theme.of(context).primaryColor)),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(children: [
                        const TextSpan(
                            style: Apptheme.titleSmall, text: "My role:  "),
                        TextSpan(
                            style: Apptheme.bodyLarge,
                            text: content[selectionProjectIndex].projectMyRole),
                      ]),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    RichText(
                      text: TextSpan(children: [
                        const TextSpan(
                            style: Apptheme.titleSmall, text: "Duration:  "),
                        TextSpan(
                            style: Apptheme.bodyLarge,
                            text:
                                content[selectionProjectIndex].projectDuration),
                      ]),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    RichText(
                      text: TextSpan(children: [
                        const TextSpan(
                            style: Apptheme.titleSmall, text: "Topics:  "),
                        TextSpan(
                            style: Apptheme.bodyLarge,
                            text: content[selectionProjectIndex].projectTopic),
                      ]),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                  style: Apptheme.bodyLarge,
                  content[selectionProjectIndex].challengeSummary),
              const SizedBox(
                height: 24,
              ),
              ColumnBuilder(
                  itemCount: content[selectionProjectIndex]
                      .paragraphContentList
                      .length,
                  itemBuilder: (BuildContext context, int paragraphIndex) {
                    return Column(
                      children: <Widget>[
                        ParagraphLayout(
                                layoutType: content[selectionProjectIndex]
                                    .paragraphContentList[paragraphIndex]
                                    .layout,
                                titleTextDisplay: true,
                                titleText: content[selectionProjectIndex]
                                    .paragraphContentList[paragraphIndex]
                                    .titleText,
                                subtitleText: content[selectionProjectIndex]
                                    .paragraphContentList[paragraphIndex]
                                    .subtitleText,
                                contentText: content[selectionProjectIndex]
                                    .paragraphContentList[paragraphIndex]
                                    .contentText,
                                context: context,
                                imageLink: content[selectionProjectIndex]
                                    .paragraphContentList[paragraphIndex]
                                    .imageLocation,
                                linkAddress: content[selectionProjectIndex]
                                    .paragraphContentList[paragraphIndex]
                                    .link,
                                navigation: (value) {})
                            .layoutSelector(),
                        const SizedBox(
                          height: 48,
                        ),
                      ],
                    );
                  }),
            ],
          ),
        ),
      ],
    );
  }
}

class ContentFrame extends StatelessWidget {
  const ContentFrame({
    super.key,
    required this.bottomNavigationActive,
    required this.deviceIsDesktop,
    required this.contentWidget,
    required this.navigation,
  });

  final bool bottomNavigationActive;
  final bool deviceIsDesktop;
  final Widget contentWidget;
  final BottomNavigation navigation;

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: ListView(
        children: <Widget>[
          deviceIsDesktop
              ? SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                )
              : const SizedBox(
                  height: 24,
                ),
          contentWidget,
          const SizedBox(
            height: 64,
          ),
          bottomNavigationActive ? navigation : const SizedBox(),
          deviceIsDesktop
              ? SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                )
              : const SizedBox(
                  height: 24,
                ),
        ],
      ),
    );
  }
}

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({
    super.key,
    required this.previousPage,
    required this.nextPage,
    required this.nextPageSummary,
  });

  final VoidCallback previousPage;
  final VoidCallback nextPage;
  final String nextPageSummary;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            onTap: previousPage,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(8),
              height: 68,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.arrow_back_rounded, size: 36),
                ],
              ),
            )),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: InkWell(
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onTap: nextPage,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(8),
                height: 68,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const Icon(Icons.arrow_forward_rounded, size: 36),
                      Expanded(
                        child: Text(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          nextPageSummary,
                          style: Apptheme.labelLarge,
                        ),
                      )
                    ]),
              )),
        ),
      ],
    );
  }
}

class Carousel extends StatefulWidget {
  const Carousel(
      {super.key, required this.jsonContent, required this.navigateToProjects});

  final JsonStructure jsonContent;
  final ValueSetter<LinkAddress> navigateToProjects;

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  late PageController _pageController;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.3, initialPage: 1000);
//    _timer = Timer.periodic(
//        const Duration(seconds: 4),
//        (Timer t) => _pageController.nextPage(
//            duration: const Duration(milliseconds: 500), curve: Curves.easeIn));
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
            pageSnapping: false,
            itemBuilder: (BuildContext context, int projectIndex) {
              if (projectIndex % 5 < widget.jsonContent.projectList.length) {
                return PreviewItem(
                  projectThumbnail: widget.jsonContent
                      .projectList[projectIndex % 5].projectThumbnail,
                  projectVideoPreview: widget.jsonContent
                      .projectList[projectIndex % 5].projectVideoPreview,
                  projectTitle: widget
                      .jsonContent.projectList[projectIndex % 5].projectTitle,
                  projectTopic: widget
                      .jsonContent.projectList[projectIndex % 5].projectTopic,
                  onItemSelection: widget.navigateToProjects,
                  linkAddress:
                      (LinkAddress(active: true, 2, projectIndex % 5, -1)),
                );
              } else {
                return PreviewItem(
                  projectThumbnail: widget
                      .jsonContent
                      .smallProjectList[projectIndex % 5 -
                          widget.jsonContent.projectList.length]
                      .projectThumbnail,
                  projectVideoPreview: widget
                      .jsonContent
                      .smallProjectList[projectIndex % 5 -
                          widget.jsonContent.projectList.length]
                      .projectVideoPreview,
                  projectTitle: widget
                      .jsonContent
                      .smallProjectList[projectIndex % 5 -
                          widget.jsonContent.projectList.length]
                      .projectTitle,
                  projectTopic: widget
                      .jsonContent
                      .smallProjectList[projectIndex % 5 -
                          widget.jsonContent.projectList.length]
                      .projectTopic,
                  onItemSelection: widget.navigateToProjects,
                  linkAddress: LinkAddress(
                      active: true,
                      3,
                      projectIndex % 5 - widget.jsonContent.projectList.length,
                      -1),
                );
              }
            }),
        Align(
          alignment: Alignment.centerLeft,
          child: HoverEffect(
            transparentBackground: true,
            context: context,
            child: SizedBox(
              width: 48,
              height: 48,
              child: GestureDetector(
                onTap: () {
                  _pageController.previousPage(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeIn);
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 48,
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: HoverEffect(
            transparentBackground: true,
            context: context,
            child: SizedBox(
              width: 48,
              height: 48,
              child: GestureDetector(
                onTap: () {
                  _pageController.nextPage(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeIn);
                },
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 48,
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Future<void> _launchUrl(String webpagelink) async {
  if (!await launchUrl(Uri.parse(webpagelink))) {
    throw Exception(webpagelink);
  }
}

class QuickLinks extends StatelessWidget {
  const QuickLinks({super.key, this.verticalLayout = true});

  final bool verticalLayout;

  List<Widget> linkIcon() {
    return [
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
    ];
  }

  @override
  Widget build(BuildContext context) {
    if (verticalLayout == true) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: linkIcon(),
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: linkIcon(),
      );
    }
  }
}

class PreviewItem extends StatelessWidget {
  const PreviewItem(
      {super.key,
      required this.projectThumbnail,
      required this.projectVideoPreview,
      required this.projectTitle,
      required this.projectTopic,
      required this.onItemSelection,
      required this.linkAddress});

  final String projectThumbnail;
  final String projectVideoPreview;
  final String projectTitle;
  final String projectTopic;
  final ValueSetter<LinkAddress> onItemSelection;
  final LinkAddress linkAddress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onItemSelection(linkAddress);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Stack(
          children: <Widget>[
            VideoPlayerScreen(projectVideoPreview),
            Align(
              alignment: Alignment.center,
              child: HoverEffect(
                context: context,
                transparentBackground: false,
                child: Container(
                  decoration: const BoxDecoration(color: Apptheme.white),
                  constraints: const BoxConstraints(maxWidth: 320),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FirebaseFutureImageBuilder(projectThumbnail),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(style: Apptheme.titleMedium, projectTitle),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                          style: Apptheme.labelMedium, 'Topics: $projectTopic'),
                    ],
                  ),
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }
}

