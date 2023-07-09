import 'dart:convert';
import 'dart:io';
import 'package:flutter_basic/notifications/presentation/notificationBox.dart';
import 'package:http/http.dart' as http;

import '../../constants.dart';

class NotificationAuth {
  static Future<List> getNotificationsList() async {
    List<NotificationBox> map = [];
    String tokenAuth = await getTokenAuth();

    final response = await http.post(
      Uri.parse(
          'https://steel-sequencer-385510.oa.r.appspot.com/rest/notifications/list'),
      headers: <String, String>{HttpHeaders.authorizationHeader: tokenAuth},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(jsonDecode(response.body));
      map = data
          .map<NotificationBox>((item) => NotificationBox.fromJson(item))
          .toList();
    }
    return map;
  }


  static Future<List> deleteNotifications() async {
    List<NotificationBox> map = [];
    String tokenAuth = await getTokenAuth();

    final response = await http.post(
      Uri.parse(
          'https://steel-sequencer-385510.oa.r.appspot.com/rest/notifications/deleteall'),
      headers: <String, String>{HttpHeaders.authorizationHeader: tokenAuth},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(jsonDecode(response.body));
      map = data
          .map<NotificationBox>((item) => NotificationBox.fromJson(item))
          .toList();
    }
    return map;
  }
}
