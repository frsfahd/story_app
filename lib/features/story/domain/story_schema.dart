class StorySchema {
  String description;
  List<int> photo;
  String filename;
  double? lat;
  double? lon;

  StorySchema({
    required this.description,
    required this.photo,
    required this.filename,
    this.lat,
    this.lon,
  });

  Map<String, dynamic> toJson() => {
    "description": description,
    "photo": photo,
    "lat": lat,
    "lon": lon,
  };
}
