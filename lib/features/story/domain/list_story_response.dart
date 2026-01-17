import 'package:story_app/models/story.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_story_response.g.dart';
part 'list_story_response.freezed.dart';

@freezed
abstract class ListStoryResponse with _$ListStoryResponse {
  const factory ListStoryResponse({
    required bool error,
    required String message,
    required List<Story> listStory,
  }) = _ListStoryResponse;

  factory ListStoryResponse.fromJson(Map<String, dynamic> json) =>
      _$ListStoryResponseFromJson(json);
}
