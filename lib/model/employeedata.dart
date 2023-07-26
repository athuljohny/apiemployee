import 'dart:convert';

class Employee {
  final int id;
  final String name;
  final String username;
  final String email;
  String? profile_Image;

  Employee(
      {required this.id,
      required this.name,
      required this.username,
      required this.email,
      this.profile_Image});

  static Employee fromJson(json) => Employee(
      id: json["id"],
      name: json["name"],
      username: json["username"],
      email: json["email"],
      profile_Image: json["profile_Image"]);
}
