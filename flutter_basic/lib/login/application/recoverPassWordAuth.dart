import 'dart:convert';
import 'package:emailjs/emailjs.dart';
import 'package:flutter_basic/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RecoverPassWordAuth {
  static const String emailJsTemplateID = 'template_04wly35';

  static bool emptyFields(String email) {
    return email.isEmpty;
  }

  static Future<bool> hasEmail(String email) async {
    String code = createId();
    Map<String, String> obj = {"email": email, "code": code};
    final response =
        await http.post(Uri.parse('$appUrl/modify/generatePassCode'),
            headers: <String, String>{
              'Content-Type': 'application/json',
            },
            body: jsonEncode(obj));
    print(response.statusCode);
    if (response.statusCode == 200) {
      _sendEmail(obj);
      saveToSharedPreferences('userId', response.body);
      return true;
    } else {
      return false;
    }
  }

  static void _sendEmail(Map<String, dynamic> obj) async {
    try {
      await EmailJS.send(
        emailJsServiceID,
        emailJsTemplateID,
        obj,
        const Options(
          publicKey: emailJsPublicKey,
          privateKey: emailJsPrivateKey,
        ),
      );
      print('RECOVER SUCCESS!');
    } catch (error) {
      if (error is EmailJSResponseStatus) {
        print('ERROR... ${error.status}: ${error.text}');
      }
      print(error.toString());
    }
  }

  static Future<bool> checkCode(String code) async {
    final response = await http.post(
      Uri.parse('$appUrl/modify/checkPassCode'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({"userId": await getUserId(), "code": code}),
    );
    print("check code:");
    print(response.statusCode);
    if (response.statusCode == 200) {
      removeFromSharedPreferences('Code');
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> recovePassword(String pwd) async {
    final response = await http.post(
      Uri.parse('$appUrl/modify/changePassword'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
          <String, String>{"userId": await getUserId(), "newPassword": pwd}),
    );
    print("change pass:");
    print(response.statusCode);
    if (response.statusCode == 200) {
      removeFromSharedPreferences('Code');
      return true;
    } else {
      return false;
    }
  }
}

Future<String> getUserId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? code = prefs.getString('userId');
  String stringCode = jsonDecode(code!) as String;
  print("TOKENN: " + stringCode);
  return stringCode;
}

Future<bool> fetchAuthenticate(String email) async {
  final response = await http.post(
    Uri.parse('$appUrl/modify/recoverPassword'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode({"email": email}),
  );
  print(response.statusCode);
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}
