// response object for various api requests (register, add new story, add new story as guest)

import 'dart:convert';

class GenericResponse {
  bool error;
  String message;

  GenericResponse({required this.error, required this.message});

  factory GenericResponse.fromRawJson(String str) =>
      GenericResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GenericResponse.fromJson(Map<String, dynamic> json) =>
      GenericResponse(error: json["error"], message: json["message"]);

  Map<String, dynamic> toJson() => {"error": error, "message": message};
}
