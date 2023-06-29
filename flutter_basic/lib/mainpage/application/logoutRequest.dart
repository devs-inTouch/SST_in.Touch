import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';

class Logout {

  static Future<bool> userLogout() async {

    bool res = await fetchLogout();
    return res;

  }



  static Future<void> removeToken(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  static Future<bool> fetchLogout() async {

    String tokenAuth = await getTokenAuth();

    final response = await http.post(
      Uri.parse('https://steel-sequencer-385510.oa.r.appspot.com/rest/logout/'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: tokenAuth
      },

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