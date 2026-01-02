import 'dart:convert';

import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String userId;
  final String name;
  final String email;

  const User({required this.userId, required this.name, required this.email});

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) =>
      User(userId: json["userId"], name: json["name"], email: json["email"]);

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "name": name,
    "email": email,
  };

  @override
  List<Object?> get props => [userId, name, email];
}
