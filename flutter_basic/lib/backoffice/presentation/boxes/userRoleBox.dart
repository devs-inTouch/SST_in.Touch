
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basic/backoffice/application/salasRequestAuth.dart';
import 'package:flutter_basic/backoffice/application/usersRoleChangeAuth.dart';

class UserRoleBox  extends StatelessWidget {
  final String username;
  final String role;

  UserRoleBox({
    required this.username,
    required this.role,
  });

  factory UserRoleBox.fromJson(Map<String, dynamic> json) {
    return UserRoleBox(
      username: json['username'],
      role: json['role'],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        title: Text('Username: $username'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('role: $role'),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                UserRoleChangeAuth.changeRole();
                print("aproved");

              },
            ),
          ],
        ),
      ),
    );
  }
}