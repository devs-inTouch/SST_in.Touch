import 'dart:convert';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

const String appUrl = "https://steel-sequencer-385510.oa.r.appspot.com/rest";

const String emailJsServiceID = 'service_ttj4pgn';
const String emailJsPublicKey = 'Rw2KylH8VjSgE6oQ-';
const String emailJsPrivateKey = 'nVegrjC7Pqfkv7dV0swMd';

var myBackground = Colors.grey[100];

var fireBaseStorageInstance = FirebaseStorage.instance;

get firebaseStorageInstance => fireBaseStorageInstance;

var textStyleBar = const TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.bold,
);
var textStyleEvents = const TextStyle(
  color: Colors.white,
  fontSize: 16.0,
);

String createId() {
  var uuid = const Uuid();
  return uuid.v1().toString();
}

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
var mainMenuDecoration = BoxDecoration(
  color: Colors.blueAccent[200],
  borderRadius: BorderRadius.circular(10),
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

Future<String> getTokenAuth() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('Token');
  Map<String, dynamic> map = jsonDecode(token!) as Map<String, dynamic>;
  String tokenAuth = map['token'];
  print("TOKENN: " + tokenAuth);
  return tokenAuth;
}

Future<String> getRole() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? jsonValue = prefs.getString('Role');
  return jsonValue!;
}

Future<void> saveToSharedPreferences(String key, String jsonValue) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(key, jsonValue);
}

Future<void> removeFromSharedPreferences(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove(key);
}
