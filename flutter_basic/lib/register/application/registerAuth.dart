import 'dart:convert';
import 'package:emailjs/emailjs.dart';
import 'package:flutter_basic/constants.dart';
import 'package:http/http.dart' as http;

class RegisterAuth {
  static const String emailJsTemplateID = 'template_zyyib8q';
  static bool emptyFields(String username, String email, String name,
      String pwd, String pwdConfirm) {
    return username.isEmpty &&
        email.isEmpty &&
        name.isEmpty &&
        pwd.isEmpty &&
        pwdConfirm.isEmpty;
  }

  static bool hasSpecialChars(String password) {
    if (password.isEmpty) {
      return false;
    }

    return password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  }

  static bool isPasswordCompliant(String password, [int minLength = 5]) {
    if (password.isEmpty) {
      return false;
    }

    bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
    bool hasDigits = password.contains(RegExp(r'[0-9]'));
    bool hasLowercase = password.contains(RegExp(r'[a-z]'));
    bool hasMinLength = password.length > minLength;

    return hasDigits & hasUppercase & hasLowercase & hasMinLength;
  }

  static bool registerUser(
      String username,
      String email,
      String name,
      String pwd,
      String studentNumber,
      String course,
      String role,
      String description,
      String department) {
    String activateCode = createId();
    String link =
        '$appUrl/register/activate?code=$activateCode&username=$username';
    Map<String, dynamic> obj = {
      "username": username,
      "name": name,
      "email": email,
      "activateLink": link
    };
    fetchAuthenticate(username, email, name, pwd, studentNumber, course, role,
            description, department, activateCode)
        .then((response) {
      if (response) {
        sendEmail(obj);
        return true;
      }
    });
    return false;
  }

  static void sendEmail(Map<String, dynamic> obj) async {
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
      print('SUCCESS!');
    } catch (error) {
      if (error is EmailJSResponseStatus) {
        print('ERROR... ${error.status}: ${error.text}');
      }
      print(error.toString());
    }
  }
}

Future<bool> fetchAuthenticate(
    String username,
    String email,
    String name,
    String pwd,
    String studentNumber,
    String course,
    String role,
    String description,
    String department,
    String activateCode) async {
  final response = await http.post(
    Uri.parse('$appUrl/register/create'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, String>{
      "username": username,
      "name": name,
      "email": email,
      "password": pwd,
      "studentNumber": studentNumber,
      "course": course,
      "role": role,
      "description": description,
      "department": department,
      "activateAccount": activateCode
    }),
  );
  print(response.statusCode);
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}
