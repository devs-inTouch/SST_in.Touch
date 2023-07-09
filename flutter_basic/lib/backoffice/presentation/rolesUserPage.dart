import 'package:flutter/material.dart';
import 'package:flutter_basic/backoffice/presentation/boxes/userRoleBox.dart';
import 'package:flutter_basic/backoffice/presentation/boxes/usersToActivateBox.dart';
import '../../constants.dart';
import '../../myAppBar.dart';
import '../application/usersRoleChangeAuth.dart';
import 'backOfficePage.dart';

class RolesUserPage extends StatefulWidget {
  const RolesUserPage({super.key});

  @override
  State<RolesUserPage> createState() => RolesUserState();
  }

  class RolesUserState extends State<RolesUserPage> {
  List users = [];

  @override
  void initState() {
  super.initState();
  fetchUsers();
  }

  Future<void> fetchUsers() async {
  final response = await UserRoleChangeAuth.getUsersAndRoles();
  setState(() {
    users = response;
  });
  print("Users fetched");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      backgroundColor: myBackground,
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              color: Colors.grey[300],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "ROLES DE CADA UTILIZADOR",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BackOffice()),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "USER:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              width: 800,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: users.length,
                itemBuilder: (BuildContext context, int index) {
                  UserRoleBox userRoleBox = users[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: UserRoleBox(
                      username: userRoleBox.username,
                      role: userRoleBox.role,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
