import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Logout {

  static Future<bool> userLogout() async {

    bool res = await fetchLogout();
    return res;

  }

  static Future<Map<String, dynamic>> getTokenInfo(String key) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? jsonString = prefs.getString(key);
      return jsonDecode(jsonString!);
  }

  static Future<void> removeToken(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  static Future<bool> fetchLogout() async {

    Map<String, dynamic> data = await getTokenInfo('Token');

    print(data['username']);

    final response = await http.post(
      Uri.parse('https://steel-sequencer-385510.oa.r.appspot.com/rest/logout/'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        "username":data['username'],
        "tokenID":data['tokenID'],
        "creationDate": data['creationDate'],
        "expirationDate": data['expirationDate'],
        "verification": data['verification']
      }),
    );
    print(response.statusCode);
    if(response.statusCode == 200) {
      await removeToken('Token');
      return true;
    } else {
      return false;
    }
  }
}