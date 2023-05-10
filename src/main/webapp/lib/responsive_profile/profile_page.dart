import 'package:flutter/material.dart';
import 'package:flutter_basic/utils/my_box.dart';
import 'package:flutter_basic/utils/my_tile.dart';

import '../constants.dart';

class ProfilePage extends StatefulWidget {
  final String name;
  final String imageAssetPath;
  final String role;
  final String year;
  final String nucleos;

  const ProfilePage({
    required this.name,
    required this.imageAssetPath,
    required this.role,
    required this.year,
    required this.nucleos,
  });

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isEditing = false;

  @override
  Widget build(BuildContext context) {
    double fem = 1;

    return Scaffold(
      appBar: myAppBar,
      drawer: myDrawer,
      backgroundColor: myBackground,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 1024 * fem,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Stack(
              children: [

                Positioned(
                  left: 1100 * fem,
                  top: 50 * fem,

                  child: SizedBox(

                    width: 150 * fem,
                    height: 150 * fem,
                    child: Container(
                      decoration: boxDecoration,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'foto de perfil :)',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),


                //info do perfil
                Positioned(
                  // info
                  left: 142 * fem,
                  top: 44 * fem,
                  child: Container(
                    width: 700 * fem,
                    height: 627 * fem,
                    decoration: boxDecoration,
                    // topBar
                    child: Column(
                      children: [
                        topBarProfile(text: "Profile"),
                        SizedBox(height: 16 * fem),
                        Expanded(
                          child: ListView(
                            padding: EdgeInsets.symmetric(horizontal: 24 * fem),
                            children: [
                              ListTile(
                                title: Text(
                                  "Name:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                trailing: SizedBox(
                                  width: 200 * fem,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: "Name space",
                                    ),
                                    enabled: _isEditing,
                                  ),
                                ),
                              ),
                              ListTile(
                                title: Text(
                                  "Email:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                trailing: SizedBox(
                                  width: 200 * fem,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: "Email space",
                                    ),
                                    enabled: _isEditing,
                                  ),
                                ),
                              ),
                              ListTile(
                                title: Text(
                                  "Role:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                trailing: SizedBox(
                                  width: 200 * fem,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: "Role space",
                                    ),
                                    enabled: _isEditing,
                                  ),
                                ),
                              ),
                              ListTile(
                                title: Text(
                                  "State:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                trailing: SizedBox(
                                  width: 200 * fem,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: "State space",
                                    ),
                                    enabled: _isEditing,
                                  ),
                                ),
                              ),
                              ListTile(
                                title: Text(
                                  "Department:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                trailing: SizedBox(
                                  width: 200 * fem,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: "Department space",
                                    ),
                                    enabled: _isEditing,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16 * fem),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _isEditing =
                                      !_isEditing; // toggle the value of _isEditing
                                });
                              },
                              child: Text(
                                _isEditing ? "Save" : "Edit",
                                // set the text based on the value of _isEditing
                                style: TextStyle(
                                  color: Color(0xff1276eb),
                                  fontSize: 16 * fem,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            // add some space between the buttons
                            TextButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    String oldPassword = "";
                                    String newPassword = "";
                                    String confirmPassword = "";

                                    return AlertDialog(
                                      title: Text("Change Password"),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextField(
                                            onChanged: (text) {
                                              oldPassword = text;
                                            },
                                            decoration: InputDecoration(
                                              labelText: "Old Password",
                                            ),
                                          ),
                                          TextField(
                                            onChanged: (text) {
                                              newPassword = text;
                                            },
                                            decoration: InputDecoration(
                                              labelText: "New Password",
                                            ),
                                          ),
                                          TextField(
                                            onChanged: (text) {
                                              confirmPassword = text;
                                            },
                                            decoration: InputDecoration(
                                              labelText: "Confirm Password",
                                            ),
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            // Handle "Confirm" button press
                                            if (newPassword ==
                                                confirmPassword) {
                                              // TODO: update password and close dialog
                                              Navigator.of(context).pop();
                                            } else {
                                              // TODO: display error message
                                            }
                                          },
                                          child: Text("Confirm"),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            // Handle "Cancel" button press
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("Cancel"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Text(
                                "Change Password",
                                style: TextStyle(
                                  color: Color(0xff1276eb),
                                  fontSize: 16 * fem,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),


                //calendario
                Positioned(
                  // rectangle6JN6 (42:4)
                  left: 930 * fem,
                  top: 270 * fem,
                  child: Container(
                    width: 559 * fem,
                    height: 400 * fem,
                    decoration: boxDecoration,
                    child: topBarProfile(text: "Calendar"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
