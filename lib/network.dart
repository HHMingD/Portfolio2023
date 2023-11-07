import 'dataparse.dart';
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'class.dart';
import 'dataparse.dart';
import 'network.dart';
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

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

class FutureImageBuilder extends StatelessWidget {
  const FutureImageBuilder(this.imageLink, {Key? key}) : super(key: key);
  final String imageLink;

  @override
  Future<String> fetchImageUrl(String value) async {
    return FirebaseStorage.instance.ref(value).getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: fetchImageUrl(
          imageLink,
        ),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != "No") {
              return Image.network(
                snapshot.data!,
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
