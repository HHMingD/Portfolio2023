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
    List<dynamic> list1 = parsedJson['Projects'];
    List<ProjectContent> projectContent =
        list1.map((i) => ProjectContent.fromJson(i)).toList();
    List<dynamic> list2 = parsedJson['SmallProjects'];
    List<SmallProjectContent> smallProjectContent =
        list2.map((i) => SmallProjectContent.fromJson(i)).toList();
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
  final String projectThumbnail;
  final String projectMyRole;
  final String teamComposition;
  final String projectDuration;
  final String projectLocation;
  final String summaryContent;
  final String impactContent;
  final List<ParagraphContent> paragraphContentList;
  final List<ChallengeContent> challengeContent;

  ProjectContent(
      {required this.projectTitle,
      required this.projectTopic,
      required this.projectThumbnail,
      required this.projectMyRole,
      required this.summaryContent,
      required this.teamComposition,
      required this.projectDuration,
      required this.projectLocation,
      required this.impactContent,
      required this.paragraphContentList,
      required this.challengeContent});

  factory ProjectContent.fromJson(Map<String, dynamic> parsedJson) {
    var list1 = parsedJson['ChallengeContent'] as List;
    List<ChallengeContent> challengeContent =
        list1.map((i) => ChallengeContent.fromJson(i)).toList();
    var list2 = parsedJson['ParagraphContentList'] as List;
    List<ParagraphContent> paragraphContent =
        list2.map((i) => ParagraphContent.fromJson(i)).toList();

    return ProjectContent(
      projectTitle: parsedJson['ProjectTitle'],
      projectTopic: parsedJson['ProjectTopic'],
      projectThumbnail: parsedJson['ProjectThumbnail'],
      projectMyRole: parsedJson['ProjectMyRole'],
      teamComposition: parsedJson['TeamComposition'],
      projectDuration: parsedJson['ProjectDuration'],
      projectLocation: parsedJson['ProjectLocation'],
      summaryContent: parsedJson['SummaryContent'],
      impactContent: parsedJson['ImpactContent'],
      paragraphContentList: paragraphContent,
      challengeContent: challengeContent,
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
  final List<ParagraphContent> paragraphContentList;

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
    required this.paragraphContentList,
  });

  factory ChallengeContent.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['ParagraphContentList'] as List;
    List<ParagraphContent> content =
        list.map((i) => ParagraphContent.fromJson(i)).toList();
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
      paragraphContentList: content,
    );
  }
}

@JsonSerializable(anyMap: true)
class SmallProjectContent {
  final String projectTitle;
  final String projectTopic;
  final String projectThumbnail;
  final String projectMyRole;
  final String projectDuration;
  final String challengeSummary;
  final List<ParagraphContent> paragraphContentList;

  SmallProjectContent({
    required this.projectTitle,
    required this.projectTopic,
    required this.projectThumbnail,
    required this.projectMyRole,
    required this.projectDuration,
    required this.challengeSummary,
    required this.paragraphContentList,
  });

  factory SmallProjectContent.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['ParagraphContentList'] as List;
    List<ParagraphContent> content =
        list.map((i) => ParagraphContent.fromJson(i)).toList();
    return SmallProjectContent(
      projectTitle: parsedJson['ProjectTitle'],
      projectTopic: parsedJson['ProjectTopic'],
      projectMyRole: parsedJson['ProjectMyRole'],
      projectThumbnail:parsedJson['ProjectThumbnail'],
      projectDuration: parsedJson['ProjectDuration'],
      challengeSummary: parsedJson['ChallengeSummary'],
      paragraphContentList: content,
    );
  }
}

@JsonSerializable(anyMap: true)
class ParagraphContent {
  final String titleText;
  final String subtitleText;
  final String imageLocation;
  final String contentText;
  final String layout;
  final LinkAddress link;

  ParagraphContent(
      {required this.titleText,
      required this.subtitleText,
      required this.imageLocation,
      required this.contentText,
      required this.layout,
      required this.link});

  factory ParagraphContent.fromJson(Map<String, dynamic> parsedJson) {
    bool linkActive = parsedJson['Link']["LinkActive"];
    int linkAdressPage = parsedJson['Link']["Page"];
    int linkAdressProject = parsedJson['Link']["Project"];
    int linkAdressChallenge = parsedJson['Link']["Challenge"];
    LinkAddress linkAddress = LinkAddress(
        active: linkActive,
        page: linkAdressPage,
        project: linkAdressProject,
        challenge: linkAdressChallenge);

    return ParagraphContent(
      titleText: parsedJson['TitleText'],
      subtitleText: parsedJson['SubtitleText'],
      imageLocation: parsedJson['ImageLocation'],
      contentText: parsedJson['ContentText'],
      layout: parsedJson['Layout'],
      link: linkAddress,
    );
  }
}

@JsonSerializable(anyMap: true)
class LinkAddress {
  final bool active;
  final int page;
  final int project;
  final int challenge;

  LinkAddress({
    required this.active,
    required this.page,
    required this.project,
    required this.challenge,
  });

  factory LinkAddress.fromJson(Map<String, dynamic> parsedJson) {
    return LinkAddress(
      active: parsedJson['LinkActive'],
      page: parsedJson['Page'],
      project: parsedJson['Project'],
      challenge: parsedJson['Challenge'],
    );
  }
}
