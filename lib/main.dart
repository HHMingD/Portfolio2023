import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:howard_chen_portfolio/apptheme.dart';
import 'class.dart';
import 'dataparse.dart';
import 'network.dart';
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:url_launcher/url_launcher.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      home: const FetchData(),
    );
  }
}

class FetchData extends StatefulWidget {
  const FetchData({super.key});

  @override
  State<StatefulWidget> createState() => _FetchDataState();
}

class _FetchDataState extends State<FetchData> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return FutureBuilder(
        future: readProjectJsonOnline(),
        builder: (BuildContext context,
            AsyncSnapshot<List<ProjectContent>> snapshot) {
          if (snapshot.hasData) {
            return MyHomePage(content: snapshot.data!);
          } else {
            print('empty');
            return Container();
          }
        });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.content});

  final List<ProjectContent> content;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  int _selectedProjectIndex = -1;
  int _selectedChallengeIndex = 0;
  bool _itemSelected = false;

  setSelectionState(int setProjectIndex, int setChallengeIndex) {
    {
      setState(() {
        _selectedProjectIndex = setProjectIndex;
        print("state set");
        _selectedChallengeIndex = setChallengeIndex;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1400),
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
                      itemCount: widget.content.length,
                      itemBuilder: (BuildContext context, int projectIndex) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            NavigationItem(
                                buttonName:
                                    "${widget.content[projectIndex].projectTitle} summary",
                                isChallenge: false,
                                isSelected:
                                    (projectIndex == _selectedProjectIndex &&
                                            _selectedChallengeIndex == -1)
                                        ? true
                                        : false,
                                onCountSelected: () {
                                  if (_itemSelected == false) {
                                    _itemSelected = true;
                                  }
                                  setSelectionState(projectIndex, -1);
                                }),
                            ListView.builder(
                                shrinkWrap: true,
                                itemCount: widget.content[projectIndex]
                                    .challengeContent.length,
                                itemBuilder:
                                    (BuildContext context, int challengeIndex) {
                                  return NavigationItem(
                                      buttonName: widget
                                          .content[projectIndex]
                                          .challengeContent[challengeIndex]
                                          .STARTitle,
                                      isChallenge: true,
                                      isSelected: (projectIndex ==
                                                  _selectedProjectIndex &&
                                              challengeIndex ==
                                                  _selectedChallengeIndex)
                                          ? true
                                          : false,
                                      onCountSelected: () {
                                        if (_itemSelected == false) {
                                          _itemSelected = true;
                                        }
                                        setSelectionState(
                                            projectIndex, challengeIndex);
                                      });
                                }),
                            NavigationItem(
                                buttonName:
                                    "${widget.content[projectIndex].projectTitle} impact",
                                isChallenge: false,
                                isSelected:
                                    (projectIndex == _selectedProjectIndex &&
                                            _selectedChallengeIndex == -2)
                                        ? true
                                        : false,
                                onCountSelected: () {
                                  if (_itemSelected == false) {
                                    _itemSelected = true;
                                  }
                                  setSelectionState(projectIndex, -2);
                                }),
                            const SizedBox(
                              height: 8,
                            ),
                            const Divider(
                              thickness: 1,
                              height: 1,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                          ],
                        );
                      })),
              const SizedBox(
                width: 23,
              ),
              Flexible(
                  fit: FlexFit.loose,
                  flex: 5,
                  child: _itemSelected
                      ? MainPageContent(
                          selectionProjectIndex: _selectedProjectIndex,
                          selectionChallengeIndex: _selectedChallengeIndex,
                          content: widget.content)
                      : AboutMeWelcome()),
              const SizedBox(
                width: 24,
              ),
              Flexible(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        clipBehavior: Clip.hardEdge,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            borderRadius: const BorderRadius.all(Radius.circular(5))),
                        child: Column(

                          children: [
                            InkWell(
                              child: Container(
                                  padding: EdgeInsets.all(12),
                                  child: const Icon(
                                    Icons.mail_outline,
                                    size: 24,
                                  )),
                              onTap: () {
                                _launchUrl('mailto:howard8479@gmail.com');
                              },
                            ),
                            SizedBox(height: 8,),
                            InkWell(
                              child: Container(
                                  padding: EdgeInsets.all(8),
                                  child: const Icon(
                                    Icons.linked_camera_outlined,
                                    size: 24,
                                  )),
                              onTap: () {
                                _launchUrl(
                                    'https://www.linkedin.com/in/howard-h-chen/');
                              },
                            ),

                          ],
                        ),
                      ),
                      SizedBox(            height: MediaQuery.of(context).size.height * 0.15,),
                    ],
                  )),
              const SizedBox(
                width: 32,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> _launchUrl(String Webpagelink) async {
  if (!await launchUrl(Uri.parse(Webpagelink))) {
    throw Exception(Webpagelink);
  }
}
