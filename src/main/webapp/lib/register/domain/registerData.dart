// To parse this JSON data, do
//
//     final registData = registDataFromJson(jsonString);

import 'dart:convert';

RegistData registDataFromJson(String str) => RegistData.fromJson(json.decode(str));

String registDataToJson(RegistData data) => json.encode(data.toJson());

class RegistData {
  String usernameClip;
  String email;
  String name;
  String pwd;
  String confPwd;
  String role;
  String department;

  RegistData({
    required this.usernameClip,
    required this.email,
    required this.name,
    required this.pwd,
    required this.confPwd,
    required this.role,
    required this.department,
  });

  factory RegistData.fromJson(Map<String, dynamic> json) => RegistData(
    usernameClip: json["usernameClip"],
    email: json["email"],
    name: json["name"],
    pwd: json["pwd"],
    confPwd: json["confPwd"],
    role: json["role"],
    department: json["department"],
  );

  Map<String, dynamic> toJson() => {
    "usernameClip": usernameClip,
    "email": email,
    "name": name,
    "pwd": pwd,
    "confPwd": confPwd,
    "role": role,
    "department": department,
  };
}