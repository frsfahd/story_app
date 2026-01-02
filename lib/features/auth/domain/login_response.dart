import 'dart:convert';

class LoginResponse {
  bool error;
  String message;
  LoginResult? loginResult;

  LoginResponse({
    required this.error,
    required this.message,
    required this.loginResult,
  });

  factory LoginResponse.fromRawJson(String str) =>
      LoginResponse.fromJson(json.decode(str));

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    error: json["error"] as bool,
    message: json["message"] as String,
    loginResult: json["loginResult"] != null
        ? LoginResult.fromJson(json["loginResult"] as Map<String, dynamic>)
        : null,
  );
}

class LoginResult {
  String userId;
  String name;
  String token;

  LoginResult({required this.userId, required this.name, required this.token});

  factory LoginResult.fromRawJson(String str) =>
      LoginResult.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginResult.fromJson(Map<String, dynamic> json) => LoginResult(
    userId: json["userId"],
    name: json["name"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "name": name,
    "token": token,
  };
}
