import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginAuth {
  static Future<AuthResult> userLogin(String username, String pwd) async {
    print("aqui");
    AuthResult res = await fetchAuthenticate(username, pwd);
    return res;
  }

  static Future<void> saveToSharedPreferences(
      String key, String jsonValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, jsonValue);
  }

  static Future<AuthResult> fetchAuthenticate(
      String username, String pwd) async {
    final response = await http.post(
      Uri.parse('https://steel-sequencer-385510.oa.r.appspot.com/rest/login/'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        "username": username,
        "password": pwd,
      }),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      saveToSharedPreferences('Token', jsonEncode(jsonResponse));
      print("RESPOSTA: $jsonResponse");
      List<String> token = jsonResponse['token'].split(".");
      print("TOKEN: $token");
      String payload = token[1];
      List<int> decodedBytes = base64Url.decode(payload);
      String decodedString = utf8.decode(decodedBytes);
      print("DECODED: $decodedString");
      Map<String, dynamic> decodedJson = json.decode(decodedString);
      String role = decodedJson['role'];
      print("ROLE: $role");
      saveToSharedPreferences('Role', role);
      return AuthResult(true, role);
    } else {
      return AuthResult(false, "");
    }
  }
}

class AuthResult {
  final bool success;
  final String role;

  AuthResult(this.success, this.role);

  get getSuccess => success;
  get getRole => role;
}
