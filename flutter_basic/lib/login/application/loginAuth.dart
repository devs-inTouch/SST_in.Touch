import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../constants.dart';

class LoginAuth {
  static Future<AuthResult> userLogin(String username, String pwd) async {
    print("aqui");
    AuthResult res = await fetchAuthenticate(username, pwd);
    return res;
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
      String payload;
      int toLen = token[1].length % 4;
      while (toLen != 0) {
        token[1] += "=";
        toLen = token[1].length % 4;
      }
      payload = token[1];
      print("PAYLOAD: $payload");
      List<int> decodedBytes = base64.decode(payload);
      print("DECODED: $decodedBytes");
      String decodedString = utf8.decode(decodedBytes);
      print("DECODED String: $decodedString");
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