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
                    color: widget.isSelected ? Apptheme.black : Apptheme.white,
                    border: Border.all(width: 1, color: Apptheme.black))
                : BoxDecoration(
                    color: widget.isSelected ? Apptheme.black : Apptheme.white,
                  ),
            child: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: widget.buttonName,
                    style: widget.isSelected
                        ? Apptheme.titleSmallHC
                        : Apptheme.titleSmall,
                  ),
                  widget.isChallenge == true
                      ? TextSpan(
                          style: widget.isSelected
                              ? Apptheme.labelTinyHC
                              : Apptheme.labelTiny,
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
      {super.key,
      required this.navigateToProjects,
      required this.jsonContent,
      required this.deviceIsDesktop});

  final bool deviceIsDesktop;
  final JsonStructure jsonContent;
  final ValueSetter<LinkAddress> navigateToProjects;

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              deviceIsDesktop? SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
              ): const SizedBox(),
              const SizedBox(height: 24),
              RichText(
                  text: TextSpan(children: <TextSpan>[
                TextSpan(
                    text: "A Product / UX / Service Designer ",
                    style: Apptheme.themeData.textTheme.headlineLarge),
                TextSpan(
                    text:
                        'experienced in owning the whole of design process with tracked record of strong delivery at pace',
                    style: Apptheme.headlineLarge.copyWith(
                        color: Apptheme.prime400, fontWeight: FontWeight.w700))
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
                                  border: Border.all(width: 1),
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
                                              style: Apptheme.titleLarge
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w700),
                                              jsonContent
                                                  .projectList[projectIndex]
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
                                  border: Border.all(width: 1),
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
                                              style: Apptheme.titleLarge
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w700),
                                              jsonContent
                                                  .smallProjectList[
                                                      smallProjectIndex]
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
              const SizedBox(
                height: 24,
              ),
              const Text(
                'This is a self-made website powered by flutter and firebase',
                style: Apptheme.titleLarge,
              ),
              const SizedBox(
                height: 24,
              ),
              const Text(
                'The portfolio itself is also a brief demonstration of my approach to a product build. It is a site with minimal but functional features.',
                style: Apptheme.bodyLarge,
              ),
              const SizedBox(
                height: 24,
              ),
              const Text(
                'Due to NDA constrains some of the images may not be available. Please feel free to reach out if you are interested in my work.',
                style: Apptheme.bodyLarge,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MainPageProjectContent extends StatelessWidget {
  const MainPageProjectContent({
    super.key,
    required this.deviceIsDesktop,
    required this.selectionProjectIndex,
    required this.selectionChallengeIndex,
    required this.content,
    required this.previousPage,
    required this.nextPage,
    required this.nextpageSummary,
    required this.navigateToProjects,
  });

  final bool deviceIsDesktop;
  final int selectionProjectIndex;
  final int selectionChallengeIndex;
  final List<ProjectContent> content;
  final VoidCallback previousPage;
  final VoidCallback nextPage;
  final String nextpageSummary;
  final ValueSetter<LinkAddress> navigateToProjects;

  Widget customExpansionTile(
      String titleText, String contentText, String label) {
    return ExpansionTile(
      shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      tilePadding: const EdgeInsets.all(8),
      collapsedTextColor: Apptheme.black,
      title: RichText(
          text: TextSpan(children: <TextSpan>[
        TextSpan(text: label, style: Apptheme.titleMedium),
        TextSpan(
            text: titleText,
            style: Apptheme.titleMedium.copyWith(
                fontWeight: FontWeight.w500, color: Apptheme.prime900))
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

  Widget mainPageContent() {
    if (selectionChallengeIndex == -1) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              style: Apptheme.headlineSmall,
              "${content[selectionProjectIndex].projectTitle} Summary"),
          const SizedBox(
            height: 24,
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Apptheme.black)),
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
                    "Location: ${content[selectionProjectIndex].projectLocation}"),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                  children: [
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
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
              'The Situation: '),
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
              'The Task: '),
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
              'The Action: '),
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
              'The Result: '),
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
                  children: [
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

  Widget pageNavigation() {
    return Row(
      children: [
        InkWell(
            onTap: previousPage,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Apptheme.black)),
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
                    border: Border.all(color: Apptheme.black)),
                padding: const EdgeInsets.all(8),
                height: 52,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const Icon(Icons.arrow_forward_rounded, size: 36),
                      Expanded(
                        child: Text(
                          nextpageSummary,
                          style: Apptheme.titleSmall,
                        ),
                      )
                    ]),
              )),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: ListView(
        children: [
          deviceIsDesktop? SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
          ): const SizedBox(),
          mainPageContent(),
          const SizedBox(height: 24),
          pageNavigation(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
          )
        ],
      ),
    );
  }
}

class MainPageSideProjectContent extends StatelessWidget {
  const MainPageSideProjectContent({
    super.key,
    required this.deviceIsDesktop,
    required this.selectionProjectIndex,
    required this.content,
  });

  final bool deviceIsDesktop;
  final int selectionProjectIndex;
  final List<SmallProjectContent> content;

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: ListView(
        children: <Widget>[
          deviceIsDesktop? SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
          ): const SizedBox(),
          Text(
              style: Apptheme.headlineSmall,
              content[selectionProjectIndex].projectTitle),
          const SizedBox(
            height: 24,
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Apptheme.black)),
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
                  children: [
                    Container(
                      height: 280,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 6,
                            child: SizedBox(
                              height: double.infinity,
                              child: ImageWithOverlay(
                                  content[selectionProjectIndex]
                                      .paragraphContentList[paragraphIndex]
                                      .imageLocation),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            flex: 4,
                            child: Text(
                                style: Apptheme.bodyMedium,
                                content[selectionProjectIndex]
                                    .paragraphContentList[paragraphIndex]
                                    .contentText),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                  ],
                );
              }),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
          )
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
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: ImageWithOverlay(imageLink),
    );
  }

  Widget titleTextComponent() {
    return ListView(
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
        titleText != ""
            ? Text(titleText,
                style: Apptheme.titleTiny.copyWith(fontWeight: FontWeight.w300))
            : const SizedBox(),
        titleText != ""
            ? const SizedBox(
                height: 24,
              )
            : const SizedBox(),
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
