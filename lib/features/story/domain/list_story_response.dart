import 'dart:convert';

import 'package:story_app/models/story.dart';

class ListStoryResponse {
  bool error;
  String message;
  List<Story> listStory;

  ListStoryResponse({
    required this.error,
    required this.message,
    required this.listStory,
  });

  factory ListStoryResponse.fromRawJson(String str) =>
      ListStoryResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListStoryResponse.fromJson(Map<String, dynamic> json) =>
      ListStoryResponse(
        error: json["error"],
        message: json["message"],
        listStory: json['listStory'] != null
            ? List<Story>.from(json["listStory"].map((x) => Story.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "listStory": List<dynamic>.from(listStory.map((x) => x.toJson())),
  };
}
