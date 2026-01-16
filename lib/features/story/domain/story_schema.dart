// class StorySchema {
//   String description;
//   List<int> photo;
//   String filename;
//   double? lat;
//   double? lon;

//   StorySchema({
//     required this.description,
//     required this.photo,
//     required this.filename,
//     this.lat,
//     this.lon,
//   });

//   Map<String, dynamic> toJson() => {
//     "description": description,
//     "photo": photo,
//     "lat": lat,
//     "lon": lon,
//   };
// }

import 'package:freezed_annotation/freezed_annotation.dart';

part 'story_schema.g.dart';
part 'story_schema.freezed.dart';

@freezed
abstract class StorySchema with _$StorySchema {
  const factory StorySchema({
    required String description,
    required List<int> photo,
    required String filename,
    double? lat,
    double? lon,
  }) = _StorySchema;

  factory StorySchema.fromJson(Map<String, dynamic> json) =>
      _$StorySchemaFromJson(json);
}
