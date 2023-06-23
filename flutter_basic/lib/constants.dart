import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_basic/maps/maps.dart';
import 'package:flutter_basic/mainpage/presentation/desktop_main_scaffold.dart';
import 'package:flutter_basic/mainpage/presentation/mobile_main_scaffold.dart';
import 'package:flutter_basic/mainpage/presentation/responsive_main_page.dart';
import 'package:flutter_basic/mainpage/presentation/tablet_main_scaffold.dart';

import 'package:flutter_basic/profile/presentation/desktop_profile_scaffold.dart';
import 'package:flutter_basic/profile/presentation/mobile_profile_scaffold.dart';
import 'package:flutter_basic/profile/presentation/tablet_profile_scaffold.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login/presentation/loginPage.dart';
import 'messages/application/chatScreen.dart';

const String appUrl = "https://steel-sequencer-385510.oa.r.appspot.com/rest";

var myBackground = Colors.white;

var textStyleBar = const TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.bold,
);
var textStyleEvents = const TextStyle(
  color: Colors.white,
  fontSize: 16.0,
);

var textStyle = const TextStyle(
  color: Colors.black,
  fontSize: 16.0,
);

Widget textTopBar(String text) {
  return Text(
    text,
    style: const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
  );
}

final buttonStyle = ElevatedButton.styleFrom(
  backgroundColor: Colors.blue.withOpacity(0.3),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0),
  ),
);

var topBarDecoration = BoxDecoration(
  color: Colors.grey[300],
  borderRadius: const BorderRadius.only(
    topLeft: Radius.circular(10),
    topRight: Radius.circular(10),
  ),
);

var hojeNaFCTPageTitles = const TextStyle(
  color: Colors.black,
  fontSize: 26.0,
  fontWeight: FontWeight.w900,
);

var boxMainMenuDecoration = BoxDecoration(
  border: Border.all(color: Colors.black),
  color: Colors.blue.withOpacity(0.3),
  borderRadius: BorderRadius.circular(10),
);

var boxDecoration = BoxDecoration(
  color: Colors.grey[100],
  borderRadius: BorderRadius.circular(8.0),
);
var boxEventDecoration = BoxDecoration(
  color: Colors.lightBlueAccent,
  borderRadius: BorderRadius.circular(8.0),
);
var topBarProfile = ({
  required String text,
}) =>
    Align(
      alignment: Alignment.topLeft,
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: Container(
          decoration: topBarDecoration,
          padding: const EdgeInsets.only(left: 16),
          // Add padding to align text to the left
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
/**
var myAppBar = AppBar(
  backgroundColor: Colors.blue[800],
  leading: GestureDetector(
    onTap: () {
      // Handle logo click
    },
    child: Padding(
      padding: EdgeInsets.only(left: 20.0), // Adjust the left padding as needed
      child: Container(
        height: 150,
        width: 150,
        child: Image.asset('assets/logo-1-RBH.png', fit: BoxFit.contain),
      ),
    ),
  ),
  actions: [
    IconButton(
      onPressed: () {
        // Handle chat icon click
      },
      icon: Icon(Icons.chat),
    ),
    IconButton(
      onPressed: () {
        // Handle notification icon click
      },
      icon: Icon(Icons.notifications),
    ),
    IconButton(
      onPressed: () {
        // Handle profile icon click
      },
      icon: Icon(Icons.person),
    ),
  ],
);
**/
var myDrawer = Drawer(
  backgroundColor: Colors.blue[600],
  width: 220,
  child: Builder(
    builder: (BuildContext context) {
      return Column(
        children: [
          DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logo-1-RBH.png',
                  width: 50,
                  height: 50,
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ResponsiveLayout(
                          mobileScaffold: MobileProfileScaffold(
                            name: 'John Doe',
                            imageAssetPath: 'assets/images/profile.jpg',
                            role: 'Developer',
                            year: '2002',
                            nucleos: 'Engineering',
                          ),
                          tabletScaffold: TabletProfileScaffold(
                            name: 'John Doe',
                            imageAssetPath: 'assets/images/profile.jpg',
                            role: 'Developer',
                            year: '2002',
                            nucleos: 'Engineering',
                          ),
                          desktopScaffold: DesktopProfileScaffold(
                            name: 'John Doe',
                            imageAssetPath: 'assets/images/profile.jpg',
                            role: 'Developer',
                            year: '2002',
                            nucleos: 'Engineering',
                          ),
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    'Profile',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ResponsiveLayout(
                    mobileScaffold: MobileScaffold(),
                    tabletScaffold: TabletScaffold(),
                    desktopScaffold: DesktopScaffold(),
                  ),
                ),
              );
            },
            child: ListTile(
              leading: const Icon(Icons.home),
              title: const Text(
                'H O M E  P A G E',
                style: TextStyle(color: Colors.white),
              ),
              tileColor: Colors.blue[900],
              selectedTileColor: Colors.blue[800],
              selected: true,
            ),
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatScreen(
                          conversation: null,
                          onConversationSelected: (Conversation) {},
                        )),
              );
            },
            child: ListTile(
              leading: const Icon(Icons.chat),
              title: const Text(
                'M E S S A G E S',
                style: TextStyle(color: Colors.white),
              ),
              tileColor: Colors.blue[900],
              selectedTileColor: Colors.blue[800],
              selected: false, // Change to true if this is the current page
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MapScreen()),
              );
            },
            child: ListTile(
              leading: const Icon(Icons.map),
              title: const Text(
                'M A P S',
                style: TextStyle(color: Colors.white),
              ),
              tileColor: Colors.blue[900],
              selectedTileColor: Colors.blue[800],
              selected: false, // Change to true if this is the current page
            ),
          ),
          const SizedBox(height: 10),
          const Spacer(),
          InkWell(
            onTap: () {
              // Function to execute when the "Logout" button is tapped
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Login()),
              );
            },
            child: ListTile(
              leading: const Icon(Icons.logout),
              title: const Text(
                'L O G O U T',
                style: TextStyle(color: Colors.white),
              ),
              tileColor: Colors.blue[900],
              selectedTileColor: Colors.blue[800],
              selected: false, // Change to true if this is the current page
            ),
          ),
        ],
      );
    },
  ),
);

Future<String> getTokenAuth() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('Token');
  Map<String, dynamic> map = jsonDecode(token!) as Map<String, dynamic>;
  String tokenAuth = map['token'];
  print("TOKENN: " + tokenAuth);
  return tokenAuth;
}

Future<void> saveToSharedPreferences(String key, String jsonValue) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(key, jsonValue);
}
