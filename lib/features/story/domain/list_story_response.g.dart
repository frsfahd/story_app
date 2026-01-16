// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_story_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ListStoryResponse _$ListStoryResponseFromJson(Map<String, dynamic> json) =>
    _ListStoryResponse(
      error: json['error'] as bool,
      message: json['message'] as String,
      listStory: (json['listStory'] as List<dynamic>)
          .map((e) => Story.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListStoryResponseToJson(_ListStoryResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'listStory': instance.listStory,
    };
