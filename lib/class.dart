import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'apptheme.dart';
import 'dataparse.dart';
import 'network.dart';

class NavigationItem extends StatefulWidget {
  const NavigationItem({super.key,
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

class MainPageContent extends StatelessWidget {
  const MainPageContent({
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
      return ListView(
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
          Text(
              style: Apptheme.bodyBase,
              content[selectionProjectIndex].summaryContent)
        ],
      );
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
              content[selectionProjectIndex].impactContent)
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
                content[selectionProjectIndex]
                    .challengeContent[selectionChallengeIndex]
                    .STARTitle),
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
                        height: 320,
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
                                  style: Apptheme.labelBase,
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

class AboutMeWelcome extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nice to meet you',
              style: Apptheme.titleSmall,
            ),
            SizedBox(
              height: 24,
            ),
            Text(
              'Welcome to my portfolio, please feel free to reach out if you are interested in my work.',
              style: Apptheme.labelLarge,
            ),
            SizedBox(
              height: 24,
            ),
            Text(
              'The portolfio itself is also a brief demonstration of how I approach product build. The site self made, powered by Flutter and Firebase with the focus on being functional, and low cost with clean interface in the shortest amount of time possible. This lean build methodology achieves functional software in the shortest amount of time possible that serves the need of being a designer`s portfolio',
              style: Apptheme.bodyBase,
            )
          ],
        ),
      ),
    );
  }
}
