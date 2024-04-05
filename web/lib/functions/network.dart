import 'package:howard_chen_portfolio/main.dart';

import '../style/app_theme.dart';
import 'json_parse.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

final contentRef = FirebaseStorage.instance.ref('content/content.json');

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
      smallProjectList: jsonStructure.smallProjectList,
    );
  } else {
    throw Exception('Failed to load project');
  }
}

late OverlayEntry overlayEntry;

class ImageBuilder extends StatelessWidget {
  const ImageBuilder(this.imageLink, {super.key});

  final String imageLink;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: FadeInImage.assetNetwork(
        fadeOutDuration: const Duration(milliseconds: 100),
        fadeInDuration: const Duration(milliseconds: 100),
        placeholder: 'imageplaceholder.png',
        image: imageLink,
        fit: BoxFit.cover,
      ),
    );
  }
}

class FirebaseFutureImageBuilder extends StatelessWidget {
  const FirebaseFutureImageBuilder(this.imageLink, {super.key});

  final String imageLink;

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
            return ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: FadeInImage.assetNetwork(
                fadeOutDuration: const Duration(milliseconds: 100),
                fadeInDuration: const Duration(milliseconds: 100),
                placeholder: 'imageplaceholder.png',
                image: snapshot.data!,
                fit: BoxFit.cover,
              ),
            );
          } else {
            return const SizedBox();
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
    Overlay.of(universalContext).insert(overlayEntry);
  }

  OverlayEntry myOverlayEntry(String location) {
    return OverlayEntry(
        maintainState: true,
        builder: (context) {
          return GestureDetector(
            onTap: () {
              overlayEntry.remove();
            },
            child: Container(
              padding: const EdgeInsets.all(32),
              decoration: const BoxDecoration(color: Color(0x66000000)),
              child: Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.85,
                  child: FirebaseFutureImageBuilder(
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
        child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColorLight,
                borderRadius: const BorderRadius.all(Radius.circular(8))),
            child: FirebaseFutureImageBuilder(widget.imageDownloadURL)));
  }
}

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen(this.videoUrl, {super.key});

  final String videoUrl;

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController? _controller;
  late String downloadUrl;
  bool controllerIsInitialised = false;
  late Future<String?> videoUrlFuture;

  Future<String?> getVideoUrl() async {
    return FirebaseStorage.instance.ref(widget.videoUrl).getDownloadURL();
  }

  @override
  void initState() {
    videoUrlFuture = getVideoUrl().then((value) {
      _controller = VideoPlayerController.networkUrl(Uri.parse(value!))
        ..initialize().then((value) {
          _controller?.setVolume(0);
          _controller?.setLooping(true);
          _controller?.play().then((_) {
            setState(() {
              controllerIsInitialised = true;
            });
          });
          return value;
        });
      return null;
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: videoUrlFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return controllerIsInitialised
              ? Container(
                  color: Apptheme.black, child: VideoPlayer(_controller!))
              : const Center(
                  child: CircularProgressIndicator(
                    color: Apptheme.white,
                  ),
                );
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: Apptheme.white,
            ),
          );
        }
      },
    );
  }
}
