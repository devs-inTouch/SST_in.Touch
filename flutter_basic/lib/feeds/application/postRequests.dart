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


  static Future<bool> clickedUp(String postID) async {
    String tokenAuth = await getTokenAuth();



    final response = await http.post(
        Uri.parse(
            'https://steel-sequencer-385510.oa.r.appspot.com/rest/post/modify/up'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          HttpHeaders.authorizationHeader: tokenAuth
        },
        body: jsonEncode(<String, String>{
          "postId":postID
        }));
    if (response.statusCode == 200) {
      return true;
    } else
      return false;

  }

  static Future<bool> clickedDown(String postID) async {
    String tokenAuth = await getTokenAuth();


    final response = await http.post(
        Uri.parse(
            'https://steel-sequencer-385510.oa.r.appspot.com/rest/post/modify/down'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          HttpHeaders.authorizationHeader: tokenAuth
        },
        body: jsonEncode(<String, String>{
          "postId":postID
        }));
    if (response.statusCode == 200) {
      return true;
    } else return false;

  }

  static Future<List<String>> checkDowns(String postID) async {
    String tokenAuth = await getTokenAuth();

    List<String> list = [];

    final response = await http.post(
        Uri.parse(
            'https://steel-sequencer-385510.oa.r.appspot.com/rest/post/check/downs'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          HttpHeaders.authorizationHeader: tokenAuth
        },
        body: jsonEncode(<String, String>{
          "postId":postID
        }));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      list = data;
      print(list);
    }
    return list;

  }

  static Future<List<String>> checkUps(String postID) async {
    String tokenAuth = await getTokenAuth();

    List<String> list = [];

    final response = await http.post(
        Uri.parse(
            'https://steel-sequencer-385510.oa.r.appspot.com/rest/post/check/ups'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          HttpHeaders.authorizationHeader: tokenAuth
        },
        body: jsonEncode(<String, String>{
          "postId":postID
        }));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      list = data;
      print(list);
    }
    return list;

  }



  static Future<List<PostBox>> getFeed() async {
    List<PostBox> map = [];

    final response = await http.post(
        Uri.parse(
            'https://steel-sequencer-385510.oa.r.appspot.com/rest/post/list'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*'
        });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      map = data.map<PostBox>((item) => PostBox.fromJson(item)).toList();
    }

    return map;
  }
}
