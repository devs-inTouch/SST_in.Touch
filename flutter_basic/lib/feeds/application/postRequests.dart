import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../constants.dart';
import '../presentation/postBox.dart';

class PostRequests {
  static Future<bool> makePostRequest(String mediaURL, String description) async {
    String tokenAuth = await getTokenAuth();

    final response = await http.post(
        Uri.parse(
            'https://steel-sequencer-385510.oa.r.appspot.com/rest/post/create'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          HttpHeaders.authorizationHeader: tokenAuth
        },
        body: jsonEncode(<String, String>{
          "description": description,
          "mediaUrl": mediaURL
        }));

    if (response.statusCode == 200) {
      return true;
    } else
      return false;
  }

  /*
  static Future<bool> addUp() {

  }*/

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
