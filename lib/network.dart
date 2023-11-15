import 'package:flutter/cupertino.dart';
import 'app_theme.dart';
import 'json_parse.dart';
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
    print('readjson success');
    return JsonStructure(
      projectList: jsonStructure.projectList,
      smallProjectList: jsonStructure.smallProjectList,
    );
  } else {
    print('readjson failed');
    throw Exception('Failed to load project');
  }
}

late OverlayEntry overlayEntry;

class FutureImageBuilder extends StatelessWidget {
  const FutureImageBuilder(this.imageLink, {super.key});

  final String imageLink;

  Future<String> fetchImageUrl(String value) async {
    return FirebaseStorage.instance.ref(value).getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    print('---- FutureBuilder built');
    return FutureBuilder<String>(
        future: fetchImageUrl(
          imageLink,
        ),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != "No") {
              print('----- data fetched, image built');
              return FadeInImage.assetNetwork(
                fadeOutDuration: const Duration(milliseconds: 100),
                fadeInDuration: const Duration(milliseconds: 100),
                placeholder: 'imageplaceholder.png',
                image: snapshot.data!,
                fit: BoxFit.cover,
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

class ImageWithOverlay extends StatefulWidget {
  const ImageWithOverlay(this.imageDownloadURL, {super.key});

  final String imageDownloadURL;

  @override
  State<ImageWithOverlay> createState() => _ImageWithOverlayState();
}

class _ImageWithOverlayState extends State<ImageWithOverlay> {
  void imageOverlay(String location) {
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
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.65,
                  child: FutureImageBuilder(
                    location,
                  ),
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          imageOverlay(widget.imageDownloadURL);
        },
        child: FutureImageBuilder(widget.imageDownloadURL));
  }
}
