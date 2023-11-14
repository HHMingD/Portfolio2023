import 'package:flutter/cupertino.dart';
import 'apptheme.dart';
import 'jsonparse.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

final contentRef = FirebaseStorage.instance.ref('content.json');

Future<List<ProjectContent>> readProjectJsonOnline() async {
  final String url = await contentRef.getDownloadURL();
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    var parsedJson = await json.decode(response.body);
    List<ProjectContent> projectList = List<ProjectContent>.from(parsedJson
        .map<ProjectContent>((dynamic i) => ProjectContent.fromJson(i))
        .toList());
    return projectList;
  } else {
    throw Exception('Failed to load project');
  }
}

Future<JsonStructure> readJsonStructureOnline() async {
  final String url = await contentRef.getDownloadURL();
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    var parsedJson = await json.decode(response.body);
    JsonStructure jsonStructure = JsonStructure.fromJson(parsedJson);

    return JsonStructure(
      projectList: jsonStructure.projectList,
      smallProjectList: jsonStructure.smallProjectList,
    );
  } else {
    throw Exception('Failed to load project');
  }
}

late OverlayEntry overlayEntry;

class FutureImageBuilder extends StatefulWidget {
  const FutureImageBuilder(this.imageLink, {super.key});

  final String imageLink;

  @override
  State<FutureImageBuilder> createState() => _FutureImageBuilderState();
}

class _FutureImageBuilderState extends State<FutureImageBuilder> {
  void showHint(String location) {
    overlayEntry = myOverlayEntry(location);
    Overlay.of(context).insert(overlayEntry);
  }

  OverlayEntry myOverlayEntry(String location) {
    return OverlayEntry(
        maintainState: true,
        builder: (context) {
          return GestureDetector(
            onTap: () {
              overlayEntry?.remove();
            },
            child: Container(
              padding: const EdgeInsets.all(32),
              decoration: const BoxDecoration(color: Color(0x66000000)),
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.65,
                  child: Image.network(
                    location,
                  ),
                ),
              ),
            ),
          );
        });
  }

  @override
  Future<String> fetchImageUrl(String value) async {
    return FirebaseStorage.instance.ref(value).getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: fetchImageUrl(
          widget.imageLink,
        ),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != "No") {
              return InkWell(
                onTap: () {
                  showHint(snapshot.data!);
                },
                child: Image.network(
                  snapshot.data!,
                  fit: BoxFit.cover,
                ),
              );
            } else {
              return const Image(image: AssetImage('imageplaceholder.png'));
            }
          } else {
            return const Image(image: AssetImage('imageplaceholder.png'));
          }
        });
  }
}
