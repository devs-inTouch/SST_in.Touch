
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basic/backoffice/application/salasRequestAuth.dart';
import 'package:flutter_basic/backoffice/application/usersRoleAuth.dart';
import 'package:flutter_basic/constants.dart';

class UserRoleBox  extends StatelessWidget {
  final String username;
  final String name;
  final String email;
  final String studentNumber;
  final String role;

  UserRoleBox({
    required this.username,
    required this.name,
    required this.email,
    required this.studentNumber,
    required this.role,
  });

  factory UserRoleBox.fromJson(Map<String, dynamic> json) {
    return UserRoleBox(
      username: json['username'],
        name: json['name'],
        email: json['email'],
        studentNumber: json['studentNumber'],
        role: json['role'],

    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.blueAccent[200],
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Username: $username',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              'Name: $name',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              'Email: $email',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              'Student Number: $studentNumber',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              'Role: $role',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

}