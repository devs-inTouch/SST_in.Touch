import 'dart:convert';
import 'dart:io';

import '../../constants.dart';
import '../model/event.dart';
import 'package:http/http.dart' as http;

class EventRequests {
  static Future<bool> createCalendarEvent(Event event) async {
    String tokenAuth = await getTokenAuth();

    final response = await http.post(Uri.parse('$appUrl/calendar/create'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          HttpHeaders.authorizationHeader: tokenAuth
        },
        body: jsonEncode(event.toJson()));

    print(response.statusCode);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<List<Event>> getCalendarEvents() async {
    String tokenAuth = await getTokenAuth();
    List<Event> map = [];

    final response = await http.post(Uri.parse('$appUrl/calendar/list'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          HttpHeaders.authorizationHeader: tokenAuth
        });
    print(response.statusCode);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      map = data.map<Event>((item) => Event.fromJson(item)).toList();
    }

    return map;
  }
}
