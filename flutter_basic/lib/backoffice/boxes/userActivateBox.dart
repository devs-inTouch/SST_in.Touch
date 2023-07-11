import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basic/backoffice/activateUser/application/activateUsersAuth.dart';

class UserActivateBox extends StatelessWidget {
  final String username;
  final String name;
  final String email;
  final String role;

  UserActivateBox({
    required this.username,
    required this.name,
    required this.email,
    required this.role,
  });

  factory UserActivateBox.fromJson(Map<String, dynamic> json) {
    return UserActivateBox(
      username: json['username'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
    );
  }
  @override
  Widget build(BuildContext context) {
    final borderColor = Colors.blueAccent[200]; // Fallback color if blueAccent[200] is null

    return Container(
      decoration: BoxDecoration(
        color: borderColor, // Setting background color to borderColor
        border: Border.all(color: Colors.blueGrey),// Adding border
        borderRadius: BorderRadius.circular(8.0), // Adding border radius
      ),
      padding: EdgeInsets.all(8.0), // Adding padding
      child: ListTile(
        title: Text(
          'Username: $username',
          style: TextStyle(
            color: Colors.white, // Setting text color to white
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4.0), // Adding padding between texts
            Text(
              'Name: $name',
              style: TextStyle(color: Colors.white),
            ),
            Text(
              'Email: $email',
              style: TextStyle(color: Colors.white),
            ),
            Text(
              'Role: $role',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 8.0), // Adding right padding to the button
              child: ElevatedButton(
                onPressed: () async {
                  await ActivateUsersAuth.activateUser(username);
                  print("Ativado");
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.black, // Setting button color to white
                ),
                child: Text('Ativar'), // Setting the button label
              ),
            ),
          ],
        ),

      ),
    );
  }

/**
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
    **/
}
