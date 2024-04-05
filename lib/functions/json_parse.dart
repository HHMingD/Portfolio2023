import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(anyMap: true)
class JsonStructure {
  JsonStructure({required this.smallProjectList});

  final List<SmallProjectContent> smallProjectList;

  factory JsonStructure.fromJson(Map<String, dynamic> parsedJson) {
    List<dynamic> list2 = parsedJson['SmallProjects'];
    List<SmallProjectContent> smallProjectContent =
        list2.map((i) => SmallProjectContent.fromJson(i)).toList();
    return JsonStructure(
      smallProjectList: smallProjectContent,
    );
  }
}

@JsonSerializable(anyMap: true)
class ProjectContent {
  final String projectTitle;
  final String projectTopic;
  final String projectClient;
  final String projectThumbnail;
  final String projectVideoPreview;
  final String projectMyRole;
  final String teamComposition;
  final String projectDuration;
  final String projectLocation;
  final List<ParagraphContent> summaryContentList;
  final List<ParagraphContent> impactContentList;
  final List<ChallengeContent> challengeContent;

  ProjectContent(
      {required this.projectTitle,
      required this.projectTopic,
      required this.projectClient,
      required this.projectThumbnail,
      required this.projectVideoPreview,
      required this.projectMyRole,
      required this.teamComposition,
      required this.projectDuration,
      required this.projectLocation,
      required this.summaryContentList,
      required this.impactContentList,
      required this.challengeContent});

  factory ProjectContent.fromJson(Map<String, dynamic> parsedJson) {
    var list1 = parsedJson['ChallengeContent'] as List;
    List<ChallengeContent> challengeContent =
        list1.map((i) => ChallengeContent.fromJson(i)).toList();
    var list2 = parsedJson['SummaryContentList'] as List;
    List<ParagraphContent> summaryContent =
        list2.map((i) => ParagraphContent.fromJson(i)).toList();
    var list3 = parsedJson['ImpactContentList'] as List;
    List<ParagraphContent> impactContent =
        list3.map((i) => ParagraphContent.fromJson(i)).toList();

    return ProjectContent(
      projectTitle: parsedJson['ProjectTitle'],
      projectTopic: parsedJson['ProjectTopic'],
      projectClient: parsedJson['ProjectClient'],
      projectThumbnail: parsedJson['ProjectThumbnail'],
      projectVideoPreview: parsedJson['ProjectVideoPreview'],
      projectMyRole: parsedJson['ProjectMyRole'],
      teamComposition: parsedJson['TeamComposition'],
      projectDuration: parsedJson['ProjectDuration'],
      projectLocation: parsedJson['ProjectLocation'],
      summaryContentList: summaryContent,
      impactContentList: impactContent,
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
  final String projectClient;
  final String projectThumbnail;
  final String projectVideoPreview;
  final String projectMyRole;
  final String teamComposition;
  final String projectDuration;
  final String projectLocation;
  final String challengeSummary;
  final List<ParagraphContent> paragraphContentList;

  SmallProjectContent({
    required this.projectTitle,
    required this.projectTopic,
    required this.projectClient,
    required this.projectThumbnail,
    required this.projectVideoPreview,
    required this.projectMyRole,
    required this.teamComposition,
    required this.projectDuration,
    required this.projectLocation,
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
      projectClient: parsedJson['ProjectClient'],
      projectThumbnail: parsedJson['ProjectThumbnail'],
      projectVideoPreview: parsedJson['ProjectVideoPreview'],
      projectMyRole: parsedJson['ProjectMyRole'],
      teamComposition: parsedJson['TeamComposition'],
      projectDuration: parsedJson['ProjectDuration'],
      projectLocation: parsedJson['ProjectLocation'],
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

  ParagraphContent(
      {required this.titleText,
      required this.subtitleText,
      required this.imageLocation,
      required this.contentText,
      required this.layout,});

  factory ParagraphContent.fromJson(Map<String, dynamic> parsedJson) {

    return ParagraphContent(
      titleText: parsedJson['TitleText'],
      subtitleText: parsedJson['SubtitleText'],
      imageLocation: parsedJson['ImageLocation'],
      contentText: parsedJson['ContentText'],
      layout: parsedJson['Layout'],
    );
  }
}

