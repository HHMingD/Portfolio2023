import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'app_theme.dart';
import 'json_parse.dart';
import 'network.dart';

class NavigationItem extends StatefulWidget {
  const NavigationItem({
    super.key,
    required this.buttonName,
    required this.isChallenge,
    required this.onCountSelected,
    required this.isSelected,
  });

  final String buttonName;
  final VoidCallback onCountSelected;
  final bool isChallenge;
  final bool isSelected;

  @override
  State<NavigationItem> createState() => _NavigationItemState();
}

class _NavigationItemState extends State<NavigationItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
          onTap: () {
            widget.onCountSelected();
          },
          onHover: (val) {
            setState(() {
              isHovered = val;
            });
          },
          child: Container(
              padding: EdgeInsets.all(isHovered ? 7 : 8),
              decoration: isHovered
                  ? BoxDecoration(
                      color: widget.isSelected
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).scaffoldBackgroundColor,
                      border: Border.all(
                          width: 1, color: Theme.of(context).primaryColor))
                  : BoxDecoration(
                      color: widget.isSelected
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).scaffoldBackgroundColor,
                    ),
              child: widget.isChallenge
                  ? RichText(
                      text: TextSpan(
                        text: widget.buttonName,
                        style: widget.isSelected
                            ? Apptheme.labelMedium.copyWith(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                fontWeight: FontWeight.w400)
                            : Apptheme.labelMedium.copyWith(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w400),
                      ),
                    )
                  : RichText(
                      text: TextSpan(
                        text: widget.buttonName,
                        style: widget.isSelected
                            ? Apptheme.labelMedium.copyWith(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                fontWeight: FontWeight.w600)
                            : Apptheme.labelMedium.copyWith(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w600),
                      ),
                    ))),
    );
  }
}

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
          SizedBox(height: MediaQuery.of(context).size.height * 0.15,),
          RichText(
              text: TextSpan(children: <TextSpan>[
            TextSpan(
                text: "Hi! I am Howard, \n",
                style: Apptheme.headlineSmall
                    .copyWith(color: Theme.of(context).primaryColorLight)),
            TextSpan(
                text: "A Product / UX / UI Designer ",
                style: Apptheme.headlineMedium.copyWith(
                    fontWeight: FontWeight.w900,
                    color: Theme.of(context).primaryColor)),
            TextSpan(
                text:
                    "experienced in owning the whole of design process with tracked record of strong delivery at pace",
                style: Apptheme.headlineMedium
                    .copyWith(color: Theme.of(context).primaryColorLight)),
          ])),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
          ),
          Container(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              children: [
                const SizedBox(height: 48),
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: jsonContent.projectList.length,
                    itemBuilder: (BuildContext context, int projectIndex) {
                      return Column(
                        children: [
                          InkWell(
                              customBorder: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              onTap: () => navigateToProjects(LinkAddress(
                                  active: true,
                                  page: 2,
                                  project: projectIndex,
                                  challenge: -1)),
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).scaffoldBackgroundColor,
                                    border: Border.all(
                                        width: 1,
                                        color: Theme.of(context).primaryColor),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5))),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: FutureImageBuilder(jsonContent
                                          .projectList[projectIndex]
                                          .projectThumbnail),
                                    ),
                                    const SizedBox(width: 24),
                                    Expanded(
                                        flex: 1,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                style: Apptheme.titleMedium,
                                                jsonContent
                                                    .projectList[projectIndex]
                                                    .projectTitle),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                                style: Apptheme.labelMedium,
                                                'Topics: ${jsonContent.projectList[projectIndex].projectTopic}'),
                                          ],
                                        ))
                                  ],
                                ),
                              )),
                          const SizedBox(
                            height: 24,
                          )
                        ],
                      );
                    }),
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: jsonContent.smallProjectList.length,
                    itemBuilder: (BuildContext context, int smallProjectIndex) {
                      return Column(
                        children: [
                          InkWell(
                              customBorder: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              onTap: () => navigateToProjects(LinkAddress(
                                  active: true,
                                  page: 3,
                                  project: smallProjectIndex,
                                  challenge: 0)),
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                    color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                    border: Border.all(
                                        width: 1,
                                        color: Theme.of(context).primaryColor),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5))),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: FutureImageBuilder(jsonContent
                                          .smallProjectList[smallProjectIndex]
                                          .projectThumbnail),
                                    ),
                                    const SizedBox(width: 24),
                                    Expanded(
                                        flex: 1,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                style: Apptheme.titleMedium,
                                                jsonContent
                                                    .smallProjectList[
                                                        smallProjectIndex]
                                                    .projectTitle),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                                style: Apptheme.labelMedium,
                                                'Topics: ${jsonContent.smallProjectList[smallProjectIndex].projectTopic}'),
                                          ],
                                        ))
                                  ],
                                ),
                              )),
                          const SizedBox(
                            height: 24,
                          )
                        ],
                      );
                    }),
                const Text(
                  'Due to NDA constrains some of the images may not be available. Please feel free to reach out if you are interested in learning more about my work.',
                  style: Apptheme.bodyMedium,
                ),
                const SizedBox(
                  height: 24,
                ),
                const Divider(
                  height: 1,
                ),
                const SizedBox(
                  height: 24,
                ),
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
                        linkAddress: LinkAddress(
                            active: false, page: 0, project: 0, challenge: 0),
                        navigation: (Value) {})
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
          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
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
          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
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
          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
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
                  navigateToProjects(LinkAddress(
                      active: true, page: 0, project: 0, challenge: 0));
                },
                child: const Row(
                  children: [
                    Icon(Icons.arrow_back),
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
                  navigateToProjects(LinkAddress(
                      active: true, page: 0, project: 0, challenge: 0));
                },
                child: const Row(
                  children: [
                    Icon(Icons.arrow_back),
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
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
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
    return Container(
      child: Row(
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
                            maxLines:2,
                            overflow: TextOverflow.ellipsis,
                            nextPageSummary,
                            style: Apptheme.labelLarge,
                          ),
                        )
                      ]),
                )),
          ),
        ],
      ),
    );
  }
}

class ParagraphLayout {
  //provide a layout-type parameters or directly call a method to use this widget.
  const ParagraphLayout({
    required this.layoutType,
    required this.titleTextDisplay,
    required this.titleText,
    required this.subtitleText,
    required this.contentText,
    required this.imageLink,
    required this.context,
    required this.linkAddress,
    required this.navigation,
  });

  final String layoutType;
  final bool titleTextDisplay;
  final String titleText;
  final String subtitleText;
  final String contentText;
  final String imageLink;
  final BuildContext context;
  final LinkAddress linkAddress;
  final ValueSetter<LinkAddress> navigation;

  Widget linkToSeeMore() {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 8,
        ),
        InkWell(
          onTap: () {
            navigation(linkAddress);
          },
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              'See More >>',
              style: Apptheme.bodyLarge.copyWith(color: Apptheme.blue),
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }

  Widget imageComponent() {
    if (imageLink != "") {
      return Column(
        children: [
          const SizedBox(
            height: 12,
          ),
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: ImageWithOverlay(imageLink),
          ),
          const SizedBox(
            height: 12,
          ),
        ],
      );
    } else {
      return const SizedBox();
    }
  }

  Widget titleTextComponent() {
    if (titleText != "") {
      return Column(
        children: <Widget>[
          titleText != ""
              ? Text(titleText, style: Apptheme.titleLarge)
              : const SizedBox(),
          titleText != ""
              ? const SizedBox(
                  height: 12,
                )
              : const SizedBox(),
        ],
      );
    } else {
      return const SizedBox();
    }
  }

  Widget subtitleTextComponent() {
    return Column(
      children: <Widget>[
        subtitleText != ""
            ? Text(subtitleText,
                style: Apptheme.labelLarge.copyWith(
                    color: Apptheme.blue, fontWeight: FontWeight.w700))
            : const SizedBox(),
        subtitleText != ""
            ? const SizedBox(
                height: 12,
              )
            : const SizedBox(),
      ],
    );
  }

  Widget contentTextComponent() {
    return RichText(
        text: TextSpan(children: [
      const WidgetSpan(
          child: SizedBox(
        width: 30,
      )),
      TextSpan(text: contentText, style: Apptheme.bodyLarge)
    ]));
  }

  Widget textOnly() {
    return SizedBox(
//      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                titleTextComponent(),
                subtitleTextComponent(),
              ],
            ),
          ),
          const SizedBox(
            width: 24,
          ),
          Expanded(
            child: Column(
              children: [
                contentTextComponent(),
                linkAddress.active ? linkToSeeMore() : const SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget columnImage() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          titleTextComponent(),
          subtitleTextComponent(),
          imageComponent(),
          const SizedBox(
            height: 8,
          ),
          contentTextComponent(),
          linkAddress.active ? linkToSeeMore() : const SizedBox(),
        ],
      ),
    );
  }

  Widget leftImage() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          titleTextComponent(),
          subtitleTextComponent(),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: imageComponent(),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      contentTextComponent(),
                      linkAddress.active ? linkToSeeMore() : const SizedBox(),
                    ],
                  ))
            ],
          ),
        ],
      ),
    );
  }

  Widget rightImage() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          titleTextComponent(),
          subtitleTextComponent(),
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      contentTextComponent(),
                      linkAddress.active ? linkToSeeMore() : const SizedBox(),
                    ],
                  )),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                flex: 1,
                child: imageComponent(),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget statement() {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(color: Theme.of(context).hoverColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 24,
            ),
            Text(titleText, style: Apptheme.labelLarge),
            const SizedBox(
              height: 12,
            ),
            Text(contentText, style: Apptheme.headlineMedium),
            const SizedBox(
              height: 24,
            ),
          ],
        ));
  }

  Widget layoutSelector() {
    if (layoutType == 'left') {
      return leftImage();
    }
    if (layoutType == 'right') {
      return rightImage();
    }
    if (layoutType == 'column') {
      return columnImage();
    }
    if (layoutType == 'statement') {
      return statement();
    }
    if (layoutType == 'onlyText') {
      return textOnly();
    } else {
      return const Align(
        alignment: Alignment.center,
        child: Text("layout not definied"),
      );
    }
  }

  Widget layoutBuild(layoutType) {
    if (layoutType == 'left') {
      return leftImage();
    }
    if (layoutType == 'right') {
      return rightImage();
    }
    if (layoutType == 'column') {
      return rightImage();
    }
    if (layoutType == 'statement') {
      return rightImage();
    }
    if (layoutType == 'onlyText') {
      return rightImage();
    } else {
      return const Text('Layout parameter incorrect. Name widget directly');
    }
  }
}
