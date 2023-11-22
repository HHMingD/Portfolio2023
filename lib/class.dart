import 'package:flutter/material.dart';
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
            child: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: widget.buttonName,
                    style: widget.isSelected
                        ? Apptheme.titleSmall.copyWith(
                            color: Theme.of(context).scaffoldBackgroundColor)
                        : Apptheme.titleSmall
                            .copyWith(color: Theme.of(context).primaryColor),
                  ),
                  widget.isChallenge == true
                      ? TextSpan(
                          style: widget.isSelected
                              ? Apptheme.labelTiny.copyWith(
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor)
                              : Apptheme.labelTiny.copyWith(
                                  color: Theme.of(context).primaryColor),
                          text: '   //Challenge'.replaceAll(' ', '\u00A0'),
                        )
                      : const TextSpan(),
                ],
              ),
            ),
          )),
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
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: <Widget>[
        const SizedBox(height: 24),
        Text.rich(TextSpan(children: <TextSpan>[
          TextSpan(
              text: "A Product / UX / Service Designer ",
              style: Apptheme.headlineLarge.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).primaryColorDark)),
          TextSpan(
              text:
                  'experienced in owning the whole of design process with tracked record of strong delivery at pace',
              style: Apptheme.headlineLarge.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).splashColor))
        ])),
        const SizedBox(height: 48),
        ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: jsonContent.projectList.length,
            itemBuilder: (BuildContext context, int projectIndex) {
              return Column(
                children: [
                  InkWell(
                      onTap: () => navigateToProjects(LinkAddress(
                          active: true,
                          page: 2,
                          project: projectIndex,
                          challenge: -1)),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1,
                                color: Theme.of(context).primaryColor),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5))),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: FutureImageBuilder(jsonContent
                                  .projectList[projectIndex].projectThumbnail),
                            ),
                            const SizedBox(width: 24),
                            Expanded(
                                flex: 1,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        style: Apptheme.titleLarge.copyWith(
                                            fontWeight: FontWeight.w700),
                                        jsonContent.projectList[projectIndex]
                                            .projectTitle),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                        style: Apptheme.titleSmall,
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
                      onTap: () => navigateToProjects(LinkAddress(
                          active: true,
                          page: 3,
                          project: smallProjectIndex,
                          challenge: 0)),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1,
                                color: Theme.of(context).primaryColor),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5))),
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        style: Apptheme.titleLarge.copyWith(
                                            fontWeight: FontWeight.w700),
                                        jsonContent
                                            .smallProjectList[smallProjectIndex]
                                            .projectTitle),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                        style: Apptheme.titleSmall,
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
                linkAddress: LinkAddress(
                    active: false, page: 0, project: 0, challenge: 0),
                navigation: (Value) {})
            .layoutSelector(),
        const SizedBox(
          height: 48,
        ),
      ],
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
            text: label,
            style: Apptheme.titleMedium
                .copyWith(color: Theme.of(context).primaryColor)),
        TextSpan(
            text: titleText,
            style: Apptheme.titleMedium.copyWith(
                fontWeight: FontWeight.w500,
                color: Theme.of(context).primaryColor))
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

  @override
  Widget build(BuildContext context) {
    if (selectionChallengeIndex == -1) {
      return ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
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
                Text(
                    style: Apptheme.titleMedium,
                    "My role: ${content[selectionProjectIndex].projectMyRole}"),
                const SizedBox(
                  height: 24,
                ),
                Text(
                    style: Apptheme.titleSmall,
                    "Duration: ${content[selectionProjectIndex].projectDuration}"),
                const SizedBox(
                  height: 24,
                ),
                Text(
                    style: Apptheme.titleSmall,
                    "Location: ${content[selectionProjectIndex].projectLocation}"),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Text(
                          style: Apptheme.titleSmall,
                          "Team: \n${content[selectionProjectIndex].teamComposition}"),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                          style: Apptheme.titleSmall,
                          "Topic: \n${content[selectionProjectIndex].projectTopic}"),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Text(
              style: Apptheme.bodyLarge,
              content[selectionProjectIndex].summaryContent),
          const SizedBox(
            height: 24,
          ),
          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount:
                  content[selectionProjectIndex].paragraphContentList.length,
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
                        imageLink: content[selectionProjectIndex]
                            .paragraphContentList[paragraphIndex]
                            .imageLocation,
                        linkAddress: content[selectionProjectIndex]
                            .paragraphContentList[paragraphIndex]
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
      return ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: <Widget>[
          Text(
            style: Apptheme.headlineSmall,
            "${content[selectionProjectIndex].projectTitle} Impact",
          ),
          const SizedBox(
            height: 24,
          ),
          Text(
              style: Apptheme.bodyLarge,
              content[selectionProjectIndex].impactContent),
          const SizedBox(
            height: 48,
          ),
        ],
      );
    } else {
      return ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: <Widget>[
          Text(
              style: Apptheme.headlineSmall,
              "Challenge: ${content[selectionProjectIndex].challengeContent[selectionChallengeIndex].STARTitle}"),
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
          const Text(style: Apptheme.titleTiny, 'Gallery'),
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
}

class MainPageSideProjectContent extends StatelessWidget {
  const MainPageSideProjectContent({
    super.key,
    required this.selectionProjectIndex,
    required this.content,
  });

  final int selectionProjectIndex;
  final List<SmallProjectContent> content;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: <Widget>[
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
              Text(
                  style: Apptheme.titleMedium,
                  "My role: ${content[selectionProjectIndex].projectMyRole}"),
              const SizedBox(
                height: 24,
              ),
              Text(
                  style: Apptheme.titleSmall,
                  "Duration: ${content[selectionProjectIndex].projectDuration}"),
              const SizedBox(
                height: 24,
              ),
              Text(
                  style: Apptheme.titleSmall,
                  "Topic: \n${content[selectionProjectIndex].projectTopic}"),
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
            itemCount:
                content[selectionProjectIndex].paragraphContentList.length,
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
    );
  }
}

class ContentColumnFrame extends StatelessWidget {
  const ContentColumnFrame({
    super.key,
    required this.bottomNavigationActive,
    required this.deviceIsDesktop,
    required this.widget,
    required this.navigation,
  });

  final bool bottomNavigationActive;
  final bool deviceIsDesktop;
  final Widget widget;
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
          widget,
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
            onTap: previousPage,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Theme.of(context).primaryColor)),
              padding: const EdgeInsets.all(8),
              height: 52,
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
              onTap: nextPage,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Theme.of(context).primaryColor)),
                padding: const EdgeInsets.all(8),
                height: 52,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const Icon(Icons.arrow_forward_rounded, size: 36),
                      Expanded(
                        child: Text(
                          nextPageSummary,
                          style: Apptheme.titleSmall,
                        ),
                      )
                    ]),
              )),
        ),
      ],
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
    required this.linkAddress,
    required this.navigation,
  });

  final String layoutType;
  final bool titleTextDisplay;
  final String titleText;
  final String subtitleText;
  final String contentText;
  final String imageLink;
  final LinkAddress linkAddress;
  final ValueSetter<LinkAddress> navigation;

  Widget linkToSeeMore() {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
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
    if (imageLink == "") {
      return const SizedBox();
    } else {
      return Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: ImageWithOverlay(imageLink),
      );
    }
  }

  Widget titleTextComponent() {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: <Widget>[
        titleText != ""
            ? Text(titleText,
                style: Apptheme.titleTiny.copyWith(fontWeight: FontWeight.w500))
            : const SizedBox(),
        titleText != ""
            ? const SizedBox(
                height: 16,
              )
            : const SizedBox(),
      ],
    );
  }

  Widget subtitleTextComponent() {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: <Widget>[
        subtitleText != ""
            ? Text(subtitleText,
                style: Apptheme.titleMedium.copyWith(
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
    return Text(contentText, style: Apptheme.bodyLarge);
  }

  Widget textOnly() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        titleTextComponent(),
        subtitleTextComponent(),
        contentTextComponent(),
        linkAddress.active ? linkToSeeMore() : const SizedBox(),
      ],
    );
  }

  Widget columnImage() {
    return Column(
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
    );
  }

  Widget leftImage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        titleTextComponent(),
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
                    subtitleTextComponent(),
                    contentTextComponent(),
                    linkAddress.active ? linkToSeeMore() : const SizedBox(),
                  ],
                ))
          ],
        ),
      ],
    );
  }

  Widget rightImage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        titleTextComponent(),
        Row(
          children: [
            Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    subtitleTextComponent(),
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
    );
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
    } else {
      return const Text('Layout parameter incorrect. Name widget directly');
    }
  }
}
