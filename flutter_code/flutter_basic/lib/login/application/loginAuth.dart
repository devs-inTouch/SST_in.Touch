import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class LoginAuth {



  static Future<bool> userLogin(String username,String pwd) async {
    print("aqui");
    bool res = await fetchAuthenticate(username, pwd);

    return res;

  }

  static Future<void> saveToSharedPreferences(String key, String jsonValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, jsonValue);
  }

  static Future<bool> fetchAuthenticate(String username, String pwd) async {

    final response = await http.post(
      Uri.parse('https://steel-sequencer-385510.oa.r.appspot.com/rest/login/'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        "username":username,
        "password":pwd,

      }),
    );
    print(response.statusCode);
    if(response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        saveToSharedPreferences('Token', jsonEncode(jsonResponse));
        print("RESPOSTA: $jsonResponse");

        return true;
    } else {
      return false;
    }
  }
}