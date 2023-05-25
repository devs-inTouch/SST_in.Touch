import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProfileAuth {
  static Future<bool> userProfile(String token) async {
    print("Obter perfil");
    bool res = await fetchAuthenticate(token);
    return res;
  }

  static Future<bool> fetchAuthenticate(String token) async {
    final response = await http.post(
      Uri.parse('https://steel-sequencer-385510.oa.r.appspot.com/rest/login/'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{"token": token}),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      print("RESPOSTA: $jsonResponse");
      String username = jsonResponse['username']; //possivelmente 0
      String department = jsonResponse['department'];
      String description = jsonResponse['description'];
      String email = jsonResponse['email'];
      String name = jsonResponse['name'];
      String number = jsonResponse['number'];

      return true;
    } else {
      return false;
    }
  }
}
