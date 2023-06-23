import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProfileRequests {
  static Future<List> getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('Token');
    Map<String, dynamic> map = jsonDecode(token!) as Map<String, dynamic>;
    print("MATI");
    print(map['token']);

    final response = await http.post(
      Uri.parse(
          'https://steel-sequencer-385510.oa.r.appspot.com/rest/profile/'),
      headers: <String, String>{HttpHeaders.authorizationHeader: map['token']},
    );

    List res = [];
    if (response.statusCode == 200) {
      res = jsonDecode(response.body);
      print(jsonDecode(response.body));
    }
    return res;
  }
}
