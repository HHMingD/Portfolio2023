import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:howard_chen_portfolio/main.dart';
import 'package:howard_chen_portfolio/pages/about_me.dart';
import 'package:howard_chen_portfolio/widgets/utility_widgets.dart';
import '../pages/book_recommendation.dart';
import '../pages/home_page_content.dart';
import '../pages/project_content.dart';
import '../style/app_theme.dart';
import 'animation.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorAKey = GlobalKey<NavigatorState>(debugLabel: 'shellA');

void navigateToProject(BuildContext context, int destinationProjectID) {
  context.push(
    '/Unlocked:TallGiraffe/project$destinationProjectID',
  );
}

void navigateBetweenProjects(BuildContext context, int destinationProjectID) {
  context.go(
    '/Unlocked:TallGiraffe/project$destinationProjectID',
  );
}

void navigateToAboutMe(BuildContext context) {
  context.go(
    '/About',
  );
}

void navigateToBookExchange(BuildContext context) {
  context.go(
    '/About/BookExchange',
  );
}

void navigateToBookList(BuildContext context, String bookList, int pageCount) {
  context.go(
    '/About/BookExchange/c=$bookList/Page$pageCount',
  );
}

void navigateToUnlockedHome(BuildContext context) {
  context.go('/Unlocked:TallGiraffe');
}

void navigateToLockedHome(BuildContext context) {
  context.go('/Locked');
}

String nextPageSummary(projectID) {
  if (projectID < jsonContent.smallProjectList.length - 2) {
    return "Next up: ${jsonContent.smallProjectList[projectID + 1]
        .projectTitle} ";
  } else {
    return "Back to summary";
  }
}

final GoRouter customRouter = GoRouter(
  initialLocation: '/Locked',
  navigatorKey: _rootNavigatorKey,
  routes: <RouteBase>[
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return FetchData(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(navigatorKey: _shellNavigatorAKey, routes: [
          GoRoute(
            path: '/Locked',
            pageBuilder: (BuildContext context, GoRouterState state) {
              return const NoTransitionPage(child: HomePage());
            },
          ),
          GoRoute(
              path: '/Unlocked:TallGiraffe',
              pageBuilder: (BuildContext context, GoRouterState state) {
                unlocked = true;
                return NoTransitionPage(
                    key: state.pageKey, child: const HomePage());
              },
              routes: [
                GoRoute(
                  path: 'project:id',
                  pageBuilder: (context, state) {
                    unlocked = true;
                    final id = state.pathParameters['id']!;
                    return NoTransitionPage(
                        child: ProjectContentPage(
                          currentPage: int.parse(id),
                          nextPageSummary: nextPageSummary(int.parse(id)),
                        ));
                  },
                )
              ]),
          ShellRoute(
              pageBuilder: (context, state, child) {
                return NoTransitionPage(child: AboutMeContent(child: child));
              },
              routes: [
                GoRoute(
                    path: '/About',
                    pageBuilder: (context, state) {
                      return const NoTransitionPage(child: AboutMe());
                    },
                    routes: [
                      GoRoute(
                          path: 'BookExchange',
                          pageBuilder: (context, state) {
                            return const NoTransitionPage(
                                child: BookExchangePageFrame());
                          },
                          routes: [
                            GoRoute(
                              path: 'c=:reference/page:pageNumbers',
                              pageBuilder: (context, state) {
                                final reference =
                                state.pathParameters['reference']!;
                                final pageNumbers =
                                state.pathParameters['pageNumbers']!;
                                return NoTransitionPage(
                                    child: ShowAllBooks(
                                      referenceCollection: reference,
                                      pageNumbers: pageNumbers,
                                    ));
                              },
                            ),
                          ]),
                    ])
              ]),
          GoRoute(path: '/SecretGuitarCotton',
              pageBuilder: (BuildContext context, GoRouterState state) {
                return NoTransitionPage(child: SecretPage());
              }
          )

        ]),
      ],
    ),
  ],
);

class NavigationPanel extends StatefulWidget {
  const NavigationPanel({
    super.key,
    required this.currentProjects,
  });

  final int currentProjects;

  @override
  State<NavigationPanel> createState() => _NavigationPanelState();
}

class _NavigationPanelState extends State<NavigationPanel> {
  late List<Widget> navigationList = [];
  late int currentProjects;

  @override
  void initState() {
    currentProjects = widget.currentProjects;
    navigationList = [];
    projectNavigation();

    super.initState();
  }

  List<Widget> projectNavigation() {
    navigationList.add(        NavigationItem(
        buttonName: 'Home',
        isSelected: false,
        disable: false,
        onItemSelection: () {
          navigateToUnlockedHome(context);
          context.pop();
        }),);
    navigationList.add(        NavigationItem(
        buttonName: 'About Me',
        isSelected: false,
        disable: false,
        onItemSelection: () {
          navigateToAboutMe(context);
          context.pop();
        }),);
    for (int smallProjectIndex = 0;
    smallProjectIndex < jsonContent.smallProjectList.length;
    smallProjectIndex++) {
      navigationList.add(          NavigationItem(
          buttonName:
          jsonContent.smallProjectList[smallProjectIndex].projectTitle,
          isSelected: (currentProjects == smallProjectIndex) ? true : false,
          disable: currentProjects == smallProjectIndex,
          onItemSelection: () {
            navigateToProject(context, smallProjectIndex);
            setState(() {
              currentProjects = smallProjectIndex;
              navigationList = [];
              projectNavigation();
            });
          }));
    }

    return navigationList;
  }

  @override
  Widget build(BuildContext context) {
    return Styling.defaultPaper(
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: navigationList,
          ),
        ),
      ),
    );
  }
}

class NavigationItem extends StatefulWidget {
  const NavigationItem({
    super.key,
    required this.buttonName,
    required this.onItemSelection,
    required this.isSelected,
    required this.disable,
  });

  final String buttonName;
  final VoidCallback onItemSelection;
  final bool isSelected;
  final bool disable;

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
            if (widget.disable == true) {} else {
              widget.onItemSelection();
            }
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
                      ? Theme
                      .of(context)
                      .primaryColor
                      : Theme
                      .of(context)
                      .scaffoldBackgroundColor,
                  border: Border.all(
                      width: 1, color: Theme
                      .of(context)
                      .primaryColor))
                  : BoxDecoration(
                color: widget.isSelected
                    ? Theme
                    .of(context)
                    .primaryColor
                    : Theme
                    .of(context)
                    .scaffoldBackgroundColor,
              ),
              child: RichText(
                text: TextSpan(
                  text: widget.buttonName,
                  style: widget.isSelected
                      ? Apptheme.labelMedium.copyWith(
                      color: Theme
                          .of(context)
                          .scaffoldBackgroundColor,
                      fontWeight: FontWeight.w600)
                      : Apptheme.labelMedium.copyWith(
                      color: Theme
                          .of(context)
                          .primaryColor,
                      fontWeight: FontWeight.w600),
                ),
              )),
        ));
  }
}
