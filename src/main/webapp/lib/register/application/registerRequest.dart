import 'dart:convert';
import 'package:http/http.dart' as http;

class RegisterAuth {

  static bool registerUser(String username, String email, String name, String pwd, String pwdConfirmation,
      String role, String department) {

    fetchAuthenticate( username,  email,  name,  pwd,  pwdConfirmation,
         role,  department);

    return true;
  }

  static Future<bool> fetchAuthenticate(String username, String email, String name, String pwd, String pwdConfirmation,
      String role, String department) async {
    final response = await http.post(
      Uri.parse('https://steel-sequencer-385510.oa.r.appspot.com/rest/register'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        "usernameClip":username,
        "email":email,
        "name":name,
        "pwd":pwd,
        "confPwd":pwdConfirmation,
        "role":role,
        "department":department
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(jsonDecode(response.body));
      return true;
    } else {
      return false;
    }
  }
}