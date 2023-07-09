import 'dart:convert';
import 'package:http/http.dart' as http;

class RegisterAuth {

  static bool emptyFields(String username, String email, String name, String pwd, String pwdConfirm) {
    return username.isEmpty && email.isEmpty && name.isEmpty && pwd.isEmpty && pwdConfirm.isEmpty;
  }

  static bool hasSpecialChars(String password) {
    if(password.isEmpty) {
      return false;
    }

    return  password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  }

  static bool isPasswordCompliant(String password, [int minLength = 5]) {
    //Null-safety ensures that password is never null
    if (password.isEmpty) {
      return false;
    }

    bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
    bool hasDigits = password.contains(RegExp(r'[0-9]'));
    bool hasLowercase = password.contains(RegExp(r'[a-z]'));
    bool hasMinLength = password.length > minLength;

    return hasDigits &
    hasUppercase &
    hasLowercase &
    hasMinLength;
  }

  static bool registerUser(String username, String email, String name, String pwd, String studentNumber, String course, String role, String staffRole,
      String description, String department) {

    fetchAuthenticate( username,  email,  name,  pwd, studentNumber, course, role, staffRole,
        description, department);


    return true;

  }

  static Future<bool> fetchAuthenticate(String username, String email, String name, String pwd, String studentNumber, String course,
      String role, String staffRole, String description, String department) async {
    final response = await http.post(
      Uri.parse('https://steel-sequencer-385510.oa.r.appspot.com/rest/register/'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        "username":username,
        "name":name,
        "email":email,
        "password":pwd,
        "studentNumber" : studentNumber,
        "course": course,
        "role":role,
        "staffRole":staffRole,
        "description":description,
        "department":department
      }),
    );

    if(response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}

