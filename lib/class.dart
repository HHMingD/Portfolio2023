import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'apptheme.dart';
import 'jsonparse.dart';
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
    // TODO: implement build
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
                        ? Apptheme.labelSmallHC
                        : Apptheme.labelSmall,
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

class MainPageProjectContent extends StatelessWidget {
  const MainPageProjectContent({
    super.key,
    required this.selectionProjectIndex,
    required this.selectionChallengeIndex,
    required this.content,
  });

  final int selectionProjectIndex;
  final int selectionChallengeIndex;
  final List<ProjectContent> content;

  Widget customExpansionTile(String titleText, String contentText) {
    return ExpansionTile(
      shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      tilePadding: const EdgeInsets.all(8),
      collapsedTextColor: Apptheme.black,
      title: Text(style: Apptheme.labelBase, titleText),
      key: GlobalKey(),
      childrenPadding: const EdgeInsets.all(8),
      children: <Widget>[
        SizedBox(
          width: double.infinity,
          child: Text(style: Apptheme.bodyBase, contentText),
        ),
      ],
    );
  }

  Widget labelSTAR(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Text(style: Apptheme.labelTiny, label),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (selectionChallengeIndex == -1) {
      return ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: ListView(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
              ),
              Text(
                  style: Apptheme.titleSmall,
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
                        style: Apptheme.labelBase,
                        "My role: ${content[selectionProjectIndex].projectMyRole}"),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                        style: Apptheme.labelSmall,
                        "Duration: ${content[selectionProjectIndex].projectDuration}"),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                        style: Apptheme.labelSmall,
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
                              style: Apptheme.labelSmall,
                              "Team: \n${content[selectionProjectIndex].teamComposition}"),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                              style: Apptheme.labelSmall,
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
                  style: Apptheme.bodyBase,
                  content[selectionProjectIndex].summaryContent),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
              ),
            ],
          ));
    }
    if (selectionChallengeIndex == -2) {
      return ListView(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
          ),
          Text(
            style: Apptheme.titleSmall,
            "${content[selectionProjectIndex].projectTitle} Impact",
          ),
          const SizedBox(
            height: 24,
          ),
          Text(
              style: Apptheme.bodyBase,
              content[selectionProjectIndex].impactContent),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
          ),
        ],
      );
    } else {
      return ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
            ),
            Text(
                style: Apptheme.titleSmall,
                "Challenge: ${content[selectionProjectIndex].challengeContent[selectionChallengeIndex].STARTitle}"),
            const SizedBox(
              height: 24,
            ),
            Text(
                style: Apptheme.bodyBase,
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
            labelSTAR('#Situation the team was in:'),
            customExpansionTile(
              content[selectionProjectIndex]
                  .challengeContent[selectionChallengeIndex]
                  .situationTitle,
              content[selectionProjectIndex]
                  .challengeContent[selectionChallengeIndex]
                  .situationContent,
            ),
            const SizedBox(
              height: 16,
            ),
            labelSTAR('#Tasks I was assigned:'),
            customExpansionTile(
              content[selectionProjectIndex]
                  .challengeContent[selectionChallengeIndex]
                  .taskTitle,
              content[selectionProjectIndex]
                  .challengeContent[selectionChallengeIndex]
                  .taskContent,
            ),
            const SizedBox(
              height: 16,
            ),
            labelSTAR('#Actions I decided to take:'),
            customExpansionTile(
              content[selectionProjectIndex]
                  .challengeContent[selectionChallengeIndex]
                  .actionTitle,
              content[selectionProjectIndex]
                  .challengeContent[selectionChallengeIndex]
                  .actionContent,
            ),
            const SizedBox(
              height: 16,
            ),
            labelSTAR('#Results the team bring:'),
            customExpansionTile(
              content[selectionProjectIndex]
                  .challengeContent[selectionChallengeIndex]
                  .resultTitle,
              content[selectionProjectIndex]
                  .challengeContent[selectionChallengeIndex]
                  .resultContent,
            ),
            const SizedBox(
              height: 24,
            ),
            const Text(style: Apptheme.titleTiny, 'Gallery'),
            const SizedBox(
              height: 24,
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: content[selectionProjectIndex]
                    .challengeContent[selectionChallengeIndex]
                    .imageContentList
                    .length,
                itemBuilder: (BuildContext context, int imageIndex) {
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
                                child: FutureImageBuilder(content[
                                        selectionProjectIndex]
                                    .challengeContent[selectionChallengeIndex]
                                    .imageContentList[imageIndex]
                                    .imageLocation),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              flex: 4,
                              child: Text(
                                  style: Apptheme.bodySmall,
                                  content[selectionProjectIndex]
                                      .challengeContent[selectionChallengeIndex]
                                      .imageContentList[imageIndex]
                                      .imageDescription),
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
            const SizedBox(
              height: 24,
            ),
          ],
        ),
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
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: ListView(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
          ),
          Text(
              style: Apptheme.titleSmall,
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
                    style: Apptheme.labelBase,
                    "My role: ${content[selectionProjectIndex].projectMyRole}"),
                const SizedBox(
                  height: 24,
                ),
                Text(
                    style: Apptheme.labelSmall,
                    "Duration: ${content[selectionProjectIndex].projectDuration}"),
                const SizedBox(
                  height: 24,
                ),
                Text(
                    style: Apptheme.labelSmall,
                    "Topic: \n${content[selectionProjectIndex].projectTopic}"),
              ],
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Text(
              style: Apptheme.bodyBase,
              content[selectionProjectIndex].challengeSummary),
          const SizedBox(
            height: 24,
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: content[selectionProjectIndex].imageContentList.length,
              itemBuilder: (BuildContext context, int imageIndex) {
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
                              child: FutureImageBuilder(
                                  content[selectionProjectIndex]
                                      .imageContentList[imageIndex]
                                      .imageLocation),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            flex: 4,
                            child: Text(
                                style: Apptheme.bodySmall,
                                content[selectionProjectIndex]
                                    .imageContentList[imageIndex]
                                    .imageDescription),
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
        ],
      ),
    );
  }
}

class MainPageWelcome extends StatelessWidget {
  const MainPageWelcome({super.key});

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
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
              ),
              Text(
                'Welcome to my portfolio',
                style: Apptheme.titleSmall,
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                'This is a self-made website powered by flutter and firebase',
                style: Apptheme.labelLarge,
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                'The portfolio itself is also a brief demonstration of my approach to a product build. It is a site with minimal but functional features.',
                style: Apptheme.bodyBase,
              ),
              const SizedBox(
                height: 24,
              ),
              const Text(
                'Due to NDA constrains some of the images may not be available. Please feel free to reach out if you are interested in my work.',
                style: Apptheme.bodyBase,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
