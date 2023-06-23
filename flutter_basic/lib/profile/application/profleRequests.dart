import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../constants.dart';

class ProfileRequests {
  static Future<List> getUserInfo() async {
    String tokenAuth = await getTokenAuth();

    final response = await http.post(
      Uri.parse(
          'https://steel-sequencer-385510.oa.r.appspot.com/rest/profile/'),
      headers: <String, String>{HttpHeaders.authorizationHeader: tokenAuth},
    );

    List res = [];
    if (response.statusCode == 200) {
      res = jsonDecode(response.body);
      print(jsonDecode(response.body));
    }
    return res;
  }
}
