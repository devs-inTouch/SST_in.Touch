import 'dart:convert';
import 'package:http/http.dart' as http;

class RegisterAuth {

  static bool registerUser(String username, String email, String name, String pwd, String studentNumber, String course,
       String description, String department) {

        fetchAuthenticate( username,  email,  name,  pwd, studentNumber, course,
          description, department);


        return true;

  }

  static Future<bool> fetchAuthenticate(String username, String email, String name, String pwd, String studentNumber, String course,
       String description, String department) async {
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