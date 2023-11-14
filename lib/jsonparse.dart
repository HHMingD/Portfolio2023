import 'package:flutter/material.dart';

// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
// import 'package:cached_network_image/cached_network_image.dart';
import 'dart:async';
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

import 'package:flutter/services.dart';

@JsonSerializable(anyMap: true)
class JsonStructure {
  JsonStructure({required this.projectList, required this.smallProjectList});
  final List<ProjectContent> projectList;
  final List<SmallProjectContent> smallProjectList;

  factory JsonStructure.fromJson(Map<String, dynamic> parsedJson) {
    var list1 = parsedJson['Projects'] as List;
    List<ProjectContent> projectContent =
    list1.map((i) => ProjectContent.fromJson(i)).toList();
    print ( projectContent);
    var list = parsedJson['SmallProjects'] as List;
    List<SmallProjectContent> smallProjectContent =
    list.map((i) => SmallProjectContent.fromJson(i)).toList();
    print ( smallProjectContent);
    return JsonStructure(
      projectList: projectContent,
      smallProjectList: smallProjectContent,
    );
  }
}

@JsonSerializable(anyMap: true)
class ProjectContent {
  final String projectTitle;
  final String projectTopic;
  final String projectMyRole;
  final String teamComposition;
  final String projectDuration;
  final String projectLocation;
  final String summaryContent;
  final String impactContent;
  final List<ChallengeContent> challengeContent;

  ProjectContent(
      {required this.projectTitle,
      required this.projectTopic,
      required this.projectMyRole,
      required this.summaryContent,
      required this.teamComposition,
      required this.projectDuration,
      required this.projectLocation,
      required this.impactContent,
      required this.challengeContent});

  factory ProjectContent.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['ChallengeContent'] as List;
    List<ChallengeContent> content =
        list.map((i) => ChallengeContent.fromJson(i)).toList();

    return ProjectContent(
      projectTitle: parsedJson['ProjectTitle'],
      projectTopic: parsedJson['ProjectTopic'],
      projectMyRole: parsedJson['ProjectMyRole'],
      teamComposition: parsedJson['TeamComposition'],
      projectDuration: parsedJson['ProjectDuration'],
      projectLocation: parsedJson['ProjectLocation'],
      summaryContent: parsedJson['SummaryContent'],
      impactContent: parsedJson['ImpactContent'],
      challengeContent: content,
    );
  }
}

@JsonSerializable(anyMap: true)
class ChallengeContent {
  final String challengeSummary;
  final String STARTitle;
  final String situationTitle;
  final String situationContent;
  final String taskTitle;
  final String taskContent;
  final String actionTitle;
  final String actionContent;
  final String resultTitle;
  final String resultContent;
  final List<ImageContent> imageContentList;

  ChallengeContent({
    required this.challengeSummary,
    required this.STARTitle,
    required this.situationContent,
    required this.taskContent,
    required this.actionContent,
    required this.resultContent,
    required this.situationTitle,
    required this.taskTitle,
    required this.actionTitle,
    required this.resultTitle,
    required this.imageContentList,
  });

  factory ChallengeContent.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['ImageContentList'] as List;
    List<ImageContent> content =
        list.map((i) => ImageContent.fromJson(i)).toList();
    return ChallengeContent(
      challengeSummary: parsedJson['ChallengeSummary'],
      STARTitle: parsedJson['STARTitle'],
      situationTitle: parsedJson['SituationTitle'],
      situationContent: parsedJson['SituationContent'],
      taskTitle: parsedJson['TaskTitle'],
      taskContent: parsedJson['TaskContent'],
      actionTitle: parsedJson['ActionTitle'],
      actionContent: parsedJson['ActionContent'],
      resultTitle: parsedJson['ResultTitle'],
      resultContent: parsedJson['ResultContent'],
      imageContentList: content,
    );
  }
}

@JsonSerializable(anyMap: true)
class SmallProjectContent {
  final String projectTitle;
  final String projectTopic;
  final String projectMyRole;
  final String projectDuration;
  final String challengeSummary;
  final List<ImageContent> imageContentList;

  SmallProjectContent({
    required this.projectTitle,
    required this.projectTopic,
    required this.projectMyRole,
    required this.projectDuration,
    required this.challengeSummary,
    required this.imageContentList,
  });

  factory SmallProjectContent.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['ImageContentList'] as List;
    List<ImageContent> content =
    list.map((i) => ImageContent.fromJson(i)).toList();
    return SmallProjectContent(
      projectTitle: parsedJson['ProjectTitle'],
      projectTopic: parsedJson['ProjectTopic'],
      projectMyRole: parsedJson['ProjectMyRole'],
      projectDuration: parsedJson['ProjectDuration'],
      challengeSummary: parsedJson['ChallengeSummary'],
      imageContentList: content,
    );
  }
}

@JsonSerializable(anyMap: true)
class ImageContent {
  final String imageLocation;
  final String imageDescription;

  ImageContent({required this.imageLocation, required this.imageDescription});

  factory ImageContent.fromJson(Map<String, dynamic> parsedJson) {
    return ImageContent(
      imageLocation: parsedJson['ImageLocation'],
      imageDescription: parsedJson['ImageDescription'],
    );
  }
}
