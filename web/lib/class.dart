import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:howard_chen_portfolio/dataparse.dart';

class NavigationItem extends StatelessWidget {
  const NavigationItem(@required this.buttonName, this.onCountSelected,
      {super.key});

  final String buttonName;
  final VoidCallback onCountSelected;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SizedBox(
      height: 48,
      child: RichText(
        text: TextSpan(
            style: Theme.of(context).textTheme.titleMedium,
            text: buttonName,
            recognizer: TapGestureRecognizer()
              ..onTap = () => onCountSelected()),
      ),
    );
  }
}

class MainPageContent extends StatelessWidget {
  const MainPageContent(
      {required this.selectionProjectIndex,
      required this.selectionChallengeIndex,
      required this.content});

  final int selectionProjectIndex;
  final int selectionChallengeIndex;
  final List<ProjectContent> content;

  Widget build(BuildContext context) {
    if (selectionChallengeIndex == 0) {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(style: Theme.of(context).textTheme.titleLarge,'Summary'),
            const SizedBox(
              height: 24,
            ),
            Text(content[selectionProjectIndex].summaryContent)
          ],
        ),
      );
    }
    if (selectionChallengeIndex == 1) {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(style: Theme.of(context).textTheme.titleLarge,'Impact'),
            const SizedBox(
              height: 24,
            ),
            Text(content[selectionProjectIndex].impactContent)
          ],
        ),
      );
    } else {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
                style: Theme.of(context).textTheme.titleLarge,
                content[selectionProjectIndex]
                    .challengeContent[selectionChallengeIndex - 2]
                    .STARTitle),
            SizedBox(
              height: 24,
            ),
            Text(style: Theme.of(context).textTheme.labelMedium, '#Situation:'),
            ExpansionTile(
              expandedCrossAxisAlignment: CrossAxisAlignment.end,
              title: Text(content[selectionProjectIndex]
                  .challengeContent[selectionChallengeIndex - 2]
                  .situationTitle),
              children: [
                SizedBox(
                  height: 8,
                ),
                Text(content[selectionProjectIndex]
                    .challengeContent[selectionChallengeIndex - 2]
                    .situationContent),
                SizedBox(
                  height: 8,
                ),
              ],
            ),
            Text(style: Theme.of(context).textTheme.labelMedium, '#Task:'),
            ExpansionTile(
              title: Text(content[selectionProjectIndex]
                  .challengeContent[selectionChallengeIndex - 2]
                  .taskTitle),
              children: [
                SizedBox(
                  height: 8,
                ),
                Text(content[selectionProjectIndex]
                    .challengeContent[selectionChallengeIndex - 2]
                    .taskContent),
                SizedBox(
                  height: 8,
                ),
              ],
            ),
            Text(style: Theme.of(context).textTheme.labelMedium, '#Action:'),
            ExpansionTile(
              title: Text(content[selectionProjectIndex]
                  .challengeContent[selectionChallengeIndex - 2]
                  .actionTitle),
              children: [
                SizedBox(
                  height: 8,
                ),
                Text(content[selectionProjectIndex]
                    .challengeContent[selectionChallengeIndex - 2]
                    .actionContent),
                SizedBox(
                  height: 8,
                ),
              ],
            ),
            Text(style: Theme.of(context).textTheme.labelMedium, '#Result:'),
            ExpansionTile(
              title: Text(content[selectionProjectIndex]
                  .challengeContent[selectionChallengeIndex - 2]
                  .resultTitle),
              children: [
                SizedBox(
                  height: 8,
                ),
                Text(content[selectionProjectIndex]
                    .challengeContent[selectionChallengeIndex - 2]
                    .resultContent),
                SizedBox(
                  height: 8,
                ),
              ],
            ),
          ],
        ),
      );
    }
  }
}
