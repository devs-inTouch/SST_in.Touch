import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basic/backoffice/application/salasRequestAuth.dart';

class AnomalyBox extends StatelessWidget {
  final String username;
  final String type;
  final String description;

  AnomalyBox({
    required this.username,
    required this.type,
    required this.description,
  });

  factory AnomalyBox.fromJson(Map<String, dynamic> json) {
    return AnomalyBox(
      username: json['username'],
      type: json['type'],
      description: json['description'],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
