// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_schema.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StorySchema _$StorySchemaFromJson(Map<String, dynamic> json) => _StorySchema(
  description: json['description'] as String,
  photo: (json['photo'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toList(),
  filename: json['filename'] as String,
  lat: (json['lat'] as num?)?.toDouble(),
  lon: (json['lon'] as num?)?.toDouble(),
);

Map<String, dynamic> _$StorySchemaToJson(_StorySchema instance) =>
    <String, dynamic>{
      'description': instance.description,
      'photo': instance.photo,
      'filename': instance.filename,
      'lat': instance.lat,
      'lon': instance.lon,
    };
