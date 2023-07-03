import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String appUrl = "https://steel-sequencer-385510.oa.r.appspot.com/rest";

var myBackground = Colors.grey[100];

var textStyleBar = const TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.bold,
);
var textStyleEvents = const TextStyle(
  color: Colors.white,
  fontSize: 16.0,
);

const MaterialColor primarySwatch = MaterialColor(0xFF020279, {
  50: Color.fromRGBO(2, 2, 121, 0.1),
  100: Color.fromRGBO(2, 2, 121, 0.2),
  200: Color.fromRGBO(2, 2, 121, 0.3),
  300: Color.fromRGBO(2, 2, 121, 0.4),
  400: Color.fromRGBO(2, 2, 121, 0.5),
  500: Color.fromRGBO(2, 2, 121, 0.6),
  600: Color.fromRGBO(2, 2, 121, 0.7),
  700: Color.fromRGBO(2, 2, 121, 0.8),
  800: Color.fromRGBO(2, 2, 121, 0.9),
  900: Color.fromRGBO(2, 2, 121, 1.0),
});

var textStyle = const TextStyle(
  color: Colors.black,
  fontSize: 16.0,
);
var textStyleReservaSalas = const TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.bold,
  fontSize: 14.0,
);
var textStyleReservaSalasButton = const TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

var styleBackOfficeButtons = ElevatedButton.styleFrom(
  padding: EdgeInsets.all(10),
  textStyle: TextStyle(fontSize: 20),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10),
  ),
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
  color: Colors.grey[400],
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
  color: Colors.grey[300],
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
