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

    static Future<List> getSearch(String name) async {
      String tokenAuth = await getTokenAuth();

      final response = await http.post(
        Uri.parse(
            'https://steel-sequencer-385510.oa.r.appspot.com/rest/profile/search'),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: tokenAuth
        },
          body: jsonEncode(<String, String>{
            "targetUsername":name
          }));


      List res = [];
      if (response.statusCode == 200) {
        res = jsonDecode(response.body);
        print(jsonDecode(response.body));
      }
      return res;
    }

    static Future<String> getUsername() async {
      String tokenAuth = await getTokenAuth();

      final response = await http.post(
        Uri.parse(
            'https://steel-sequencer-385510.oa.r.appspot.com/rest/profile/getUsername'),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: tokenAuth
        }
      );

      String username = '';
      if (response.statusCode == 200) {
        username = jsonDecode(response.body);
        print(jsonDecode(response.body));
      }
      return username;
    }

    static Future<List> getUserInfo(String name) async {
      String tokenAuth = await getTokenAuth();
      print(name);

      final response = await http.post(
        Uri.parse(
            'https://steel-sequencer-385510.oa.r.appspot.com/rest/profile/'),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: tokenAuth
        },body: jsonEncode(<String, String>{
          "targetUsername": name
        })
      );

      List res = [];
      if (response.statusCode == 200) {
        res = jsonDecode(response.body);
        print(jsonDecode(response.body));
      }
      return res;
    }
}
