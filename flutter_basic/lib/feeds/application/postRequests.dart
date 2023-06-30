import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../presentation/postBox.dart';

class PostRequests {
  static Future<bool> makePostRequest(
      String mediaURL, String description) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('Token');
    Map<String, dynamic> map = jsonDecode(token!) as Map<String, dynamic>;
    String username = map['username'];
    print("Request");
    print(mediaURL);

    final response = await http.post(
        Uri.parse(
            'https://steel-sequencer-385510.oa.r.appspot.com/rest/post/create'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          "username": username,
          "description": description,
          "mediaUrl": mediaURL
        }));

    if (response.statusCode == 200) {
      return true;
    } else
      return false;
  }

<<<<<<< Updated upstream
=======

  /*static Future<bool> addUp() {

  }*/

>>>>>>> Stashed changes
  static Future<List<PostBox>> getFeed() async {
    List<PostBox> map = [];

    final response = await http.post(
        Uri.parse(
            'https://steel-sequencer-385510.oa.r.appspot.com/rest/post/list'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      map = data.map<PostBox>((item) => PostBox.fromJson(item)).toList();
    }

    return map;
  }
}
