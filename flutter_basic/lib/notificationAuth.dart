import 'dart:convert';
import 'dart:io';

import 'constants.dart';
import 'package:http/http.dart' as http;

class NotificationAuth {
  static Future<bool> notificationList() async {
    String tokenAuth = await getTokenAuth();
    print("NOT AUTH" + tokenAuth);

    final response = await http.post(
      Uri.parse('$appUrl/notifications/list'),
      headers: <String, String>{HttpHeaders.authorizationHeader: tokenAuth},
    );

    List res = [];
    if (response.statusCode == 200) {
      res = jsonDecode(response.body);
      print("NOT LIST");
      print(res);
      saveToSharedPreferences('NotList', jsonEncode(res));
      return true;
    }
    return false;
  }
}
