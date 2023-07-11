import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../constants.dart';
import '../boxes/userActivateBox.dart';
import '../boxes/userRoleBox.dart';

class UserRoleAuth {
  static Future<List<UserRoleBox>> getUsersList() async {
    List<UserRoleBox> map = [];
    String tokenAuth = await getTokenAuth();

    final response = await http.post(
      Uri.parse(
          'https://steel-sequencer-385510.oa.r.appspot.com/rest/list/users'),
      headers: <String, String>{HttpHeaders.authorizationHeader: tokenAuth},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(jsonDecode(response.body));
      map =
          data.map<UserRoleBox>((item) => UserRoleBox.fromJson(item)).toList();
    }
    return map;
  }

  static Future<List<UserRoleBox>> saveNewRole() async {
    List<UserRoleBox> map = [];
    String tokenAuth = await getTokenAuth();

    final response = await http.post(
      Uri.parse(
          'https://steel-sequencer-385510.oa.r.appspot.com/rest/list/active'),
      headers: <String, String>{HttpHeaders.authorizationHeader: tokenAuth},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(jsonDecode(response.body));
      map =
          data.map<UserRoleBox>((item) => UserRoleBox.fromJson(item)).toList();
    }
    return map;
  }

  static void changeRole() {}
}
