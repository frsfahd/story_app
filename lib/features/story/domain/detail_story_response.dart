import 'package:story_app/models/story.dart';

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
