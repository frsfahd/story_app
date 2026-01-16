import 'dart:convert';

// class Story {
//   String id;
//   String name;
//   String description;
//   String photoUrl;
//   DateTime createdAt;
//   double? lat;
//   double? lon;

//   Story({
//     required this.id,
//     required this.name,
//     required this.description,
//     required this.photoUrl,
//     required this.createdAt,
//     this.lat,
//     this.lon,
//   });

//   factory Story.fromRawJson(String str) => Story.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory Story.fromJson(Map<String, dynamic> json) => Story(
//     id: json["id"],
//     name: json["name"],
//     description: json["description"],
//     photoUrl: json["photoUrl"],
//     createdAt: DateTime.parse(json["createdAt"]),
//     lat: json["lat"]?.toDouble(),
//     lon: json["lon"]?.toDouble(),
//   );

//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "description": description,
//     "photoUrl": photoUrl,
//     "createdAt": createdAt.toIso8601String(),
//     "lat": lat,
//     "lon": lon,
//   };
// }

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'story.g.dart';
part 'story.freezed.dart';

@freezed
abstract class Story with _$Story {
  const factory Story({
    required String id,
    required String name,
    required String description,
    required String photoUrl,
    required DateTime createdAt,
    double? lat,
    double? lon,
  }) = _Story;

  factory Story.fromJson(Map<String, dynamic> json) => _$StoryFromJson(json);
}
