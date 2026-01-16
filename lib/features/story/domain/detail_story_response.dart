import 'dart:convert';

import 'package:story_app/models/story.dart';

// class DetailStoryResponse {
//   bool error;
//   String message;
//   Story story;

//   DetailStoryResponse({
//     required this.error,
//     required this.message,
//     required this.story,
//   });

//   factory DetailStoryResponse.fromRawJson(String str) =>
//       DetailStoryResponse.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory DetailStoryResponse.fromJson(Map<String, dynamic> json) =>
//       DetailStoryResponse(
//         error: json["error"],
//         message: json["message"],
//         story: Story.fromJson(json["story"]),
//       );

//   Map<String, dynamic> toJson() => {
//     "error": error,
//     "message": message,
//     "story": story.toJson(),
//   };
// }

import 'package:freezed_annotation/freezed_annotation.dart';

part 'detail_story_response.g.dart';
part 'detail_story_response.freezed.dart';

@freezed
abstract class DetailStoryResponse with _$DetailStoryResponse {
  const factory DetailStoryResponse({
    required bool error,
    required String messsage,
    required Story story,
  }) = _DetailStoryResponse;

  factory DetailStoryResponse.fromJson(Map<String, dynamic> json) =>
      _$DetailStoryResponseFromJson(json);
}
