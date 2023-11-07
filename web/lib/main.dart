import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'class.dart';
import 'dataparse.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedProjectIndex = 0;
  int _selectedChallengeIndex = 0;
  NavigationRailLabelType labelType = NavigationRailLabelType.all;
  bool showLeading = false;
  bool showTrailing = false;
  double groupAlignment = -1.0;

  Future<List<ProjectContent>> readProjectJson() async {
    final String response = await rootBundle.loadString('content.json');
    var parsedJson = await json.decode(response);
    print(parsedJson[1]['ProjectTitle']);
    List<ProjectContent> projectList = List<ProjectContent>.from(parsedJson
        .map<ProjectContent>((dynamic i) => ProjectContent.fromJson(i))
        .toList());
    return projectList;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: readProjectJson(),
        builder: (BuildContext context,
            AsyncSnapshot<List<ProjectContent>> snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              body: Center(
                child: Container(
                  constraints: BoxConstraints(maxWidth: 1400),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(
                        width: 32,
                      ),
                      Expanded(
                          flex: 2,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data?.length,
                              itemBuilder:
                                  (BuildContext context, int projectIndex) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    NavigationItem(
                                        snapshot.data![projectIndex]
                                                .projectTitle +
                                            " summary", () {
                                      setState(() {
                                        _selectedProjectIndex = projectIndex;
                                        _selectedChallengeIndex = 0;
                                      });
                                    }),
                                    ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: snapshot.data?[projectIndex]
                                            .challengeContent.length,
                                        itemBuilder:
                                            (BuildContext context, int challengeIndex) {
                                          return NavigationItem(
                                              snapshot
                                                  .data![projectIndex]
                                                  .challengeContent[challengeIndex]
                                                  .STARTitle, () {
                                            setState(() {
                                              _selectedProjectIndex =
                                                  projectIndex;
                                              _selectedChallengeIndex =
                                                  challengeIndex + 2;
                                            });
                                          });
                                        }),
                                    NavigationItem(
                                        snapshot.data![projectIndex]
                                                .projectTitle +
                                            " impact", () {
                                      setState(() {
                                        _selectedProjectIndex = projectIndex;
                                        _selectedChallengeIndex = 1;
                                      });
                                    }),
                                  ],
                                );
                              })),
                      const VerticalDivider(thickness: 1, width: 1),
                      const SizedBox(
                        width: 23,
                      ),
                      Expanded(
                          flex: 5,
                          child: MainPageContent(
                              selectionProjectIndex: _selectedProjectIndex,
                              selectionChallengeIndex: _selectedChallengeIndex,
                              content: snapshot.data!)),
                      const SizedBox(
                        width: 24,
                      ),
                      const Expanded(
                        flex: 2,
                        child: SizedBox(),
                      ),
                      const SizedBox(
                        width: 32,
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            print('empty');
            return Container();
          }
        });
  }
}
