import 'package:flutter/material.dart';
import '../main.dart';
import '../style/app_theme.dart';
import '../widgets/navigation.dart';
import '../widgets/utility_widgets.dart';

class ProjectContentPage extends StatelessWidget {
  const ProjectContentPage(
      {required this.currentPage, required this.nextPageSummary, super.key});

  final int currentPage;
  final String nextPageSummary;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1400),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Styling.horizontalPadding,
            deviceIsDesktop
                ? Expanded(
                    flex: 2,
                    child: NavigationPanel(
                      currentProjects: currentPage,
                    ))
                : const SizedBox(),
            deviceIsDesktop ? Styling.gridSpacing : const SizedBox(),
            Expanded(
              flex: 5,
              child: ScrollConfiguration(
                behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
                child: ListView(
                  children: <Widget>[
                    deviceIsDesktop
                        ? SizedBox(
                      height: MediaQuery.of(context).size.height * 0.15,
                    )
                        : const SizedBox(
                      height: 24,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Styling.largePaper(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              HoverEffect(
                                onTap: () {
                                  navigateToUnlockedHome(context);
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
                              Styling.contentMediumSpacing,
                              Text(
                                  style: Apptheme.headlineSmall,
                                  jsonContent
                                      .smallProjectList[currentPage].projectTitle),
                              Styling.contentMediumSpacing,
                              Container(
                                decoration: Styling.elevatedState,
                                padding: Styling.smallPadding,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    RichText(
                                      text: TextSpan(children: [
                                        const TextSpan(
                                            style: Apptheme.titleSmall, text: "My role:  "),
                                        TextSpan(
                                            style: Apptheme.bodyLarge,
                                            text: jsonContent
                                                .smallProjectList[currentPage]
                                                .projectMyRole),
                                      ]),
                                    ),
                                    Styling.contentMediumSpacing,
                                    RichText(
                                      text: TextSpan(children: [
                                        const TextSpan(
                                            style: Apptheme.titleSmall, text: "Duration:  "),
                                        TextSpan(
                                            style: Apptheme.bodyLarge,
                                            text: jsonContent
                                                .smallProjectList[currentPage]
                                                .projectDuration),
                                      ]),
                                    ),
                                    Styling.contentMediumSpacing,
                                    RichText(
                                      text: TextSpan(children: [
                                        const TextSpan(
                                            style: Apptheme.titleSmall, text: "Location:  "),
                                        TextSpan(
                                            style: Apptheme.bodyLarge,
                                            text: jsonContent
                                                .smallProjectList[currentPage]
                                                .projectLocation),
                                      ]),
                                    ),
                                    Styling.contentMediumSpacing,
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Expanded(
                                          flex: 1,
                                          child: RichText(
                                            text: TextSpan(children: [
                                              const TextSpan(
                                                  style: Apptheme.titleSmall,
                                                  text: "Team:  \n"),
                                              TextSpan(
                                                  style: Apptheme.bodyLarge,
                                                  text: jsonContent
                                                      .smallProjectList[currentPage]
                                                      .teamComposition),
                                            ]),
                                          ),
                                        ),
                                        Styling.contentSmallSpacing,
                                        Expanded(
                                          flex: 1,
                                          child: RichText(
                                            text: TextSpan(children: [
                                              const TextSpan(
                                                  style: Apptheme.titleSmall,
                                                  text: "Topic:  \n"),
                                              TextSpan(
                                                  style: Apptheme.bodyLarge,
                                                  text: jsonContent
                                                      .smallProjectList[currentPage]
                                                      .projectTopic),
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
                              Text(
                                  style: Apptheme.bodyLarge,
                                  jsonContent.smallProjectList[currentPage]
                                      .challengeSummary),
                              const SizedBox(
                                height: 24,
                              ),
                              ColumnBuilder(
                                  itemCount: jsonContent.smallProjectList[currentPage]
                                      .paragraphContentList.length,
                                  itemBuilder: (BuildContext context, int paragraphIndex) {
                                    return Column(
                                      children: <Widget>[
                                        ParagraphLayout(
                                            layoutType: jsonContent
                                                .smallProjectList[currentPage]
                                                .paragraphContentList[paragraphIndex]
                                                .layout,
                                            titleTextDisplay: true,
                                            titleText: jsonContent
                                                .smallProjectList[currentPage]
                                                .paragraphContentList[paragraphIndex]
                                                .titleText,
                                            subtitleText: jsonContent
                                                .smallProjectList[currentPage]
                                                .paragraphContentList[paragraphIndex]
                                                .subtitleText,
                                            contentText: jsonContent
                                                .smallProjectList[currentPage]
                                                .paragraphContentList[paragraphIndex]
                                                .contentText,
                                            imageLink: jsonContent
                                                .smallProjectList[currentPage]
                                                .paragraphContentList[paragraphIndex]
                                                .imageLocation,)
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
                    ),
                    const SizedBox(
                      height: 64,
                    ),
                    BottomNavigation(
                        previousPage: () {
                          if (currentPage == 0) {
                            navigateToUnlockedHome(context);
                          } else {
                            navigateToProject(
                                context, currentPage-1);
                          }
                        },
                        nextPage: () {
                          if (currentPage ==
                              jsonContent.smallProjectList.length - 1) {
                            navigateToUnlockedHome(context);
                          } else {
                            navigateToProject(
                                context, currentPage + 1);
                          }
                        },
                        nextPageSummary: nextPageSummary),
                    deviceIsDesktop
                        ? SizedBox(
                      height: MediaQuery.of(context).size.height * 0.15,
                    )
                        : const SizedBox(
                      height: 24,
                    ),
                  ],
                ),
              ),
            ),
            deviceIsDesktop ? Styling.gridSpacing : const SizedBox(),
            deviceIsDesktop
                ? const Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        QuickLinks(),
                      ],
                    ))
                : const SizedBox(),
            Styling.horizontalPadding,
          ],
        ),
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
        HoverEffect(
            onTap: previousPage,
            child: Container(
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
          child: HoverEffect(
              onTap: nextPage,
              child: Container(
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
