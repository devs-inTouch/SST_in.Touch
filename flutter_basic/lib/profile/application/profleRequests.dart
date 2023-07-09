import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../constants.dart';

class ProfileRequests {
    static Future<bool> followUser(String username) async {
      String tokenAuth = await getTokenAuth();

      final response = await http.post(
        Uri.parse("https://steel-sequencer-385510.oa.r.appspot.com/rest/profile/"),
        headers: <String,String> {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: tokenAuth
        },
        body: {
          "userToFollow": username
        }
      );

      if(response.statusCode == 200) {
        return true;
      }
      return false;
    }

    static Future<bool> unfollowUser(String username) async {
      String tokenAuth = await getTokenAuth();

      final response = await http.post(
          Uri.parse("https://steel-sequencer-385510.oa.r.appspot.com/rest/profile/"),
          headers: <String,String> {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader: tokenAuth
          },
          body: {
            "userToFollow": username
          }
      );

      if(response.statusCode == 200) {
        return true;
      }
      return false;
    }

    static Future<bool> followState(String username) async {
      String tokenAuth = await getTokenAuth();

      final response = await http.post(
          Uri.parse("https://steel-sequencer-385510.oa.r.appspot.com/rest/profile/"),
          headers: <String,String> {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader: tokenAuth
          },
          body: {
            "userToFollow": username
          }
      );

      if(response.statusCode == 200) {
        return true;
      }
      return false;
    }

    static Future<List> getUserInfo() async {
      String tokenAuth = await getTokenAuth();

      final response = await http.post(
        Uri.parse(
            'https://steel-sequencer-385510.oa.r.appspot.com/rest/profile/'),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: tokenAuth
        },
      );

      List res = [];
      if (response.statusCode == 200) {
        res = jsonDecode(response.body);
        print(jsonDecode(response.body));
      }
      return res;
    }
}
