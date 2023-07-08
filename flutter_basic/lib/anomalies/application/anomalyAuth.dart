import 'dart:convert';
import 'dart:io';
import 'package:flutter_basic/anomalies/presentation/anomalyBox.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';

class AnomalyAuth {
  static Future<List<AnomalyBox>> getAnomaliesList() async {
    List<AnomalyBox> map = [];
    String tokenAuth = await getTokenAuth();

    final response = await http.post(
      Uri.parse(
          'https://steel-sequencer-385510.oa.r.appspot.com/rest/anomaly/list'),
      headers: <String, String>{HttpHeaders.authorizationHeader: tokenAuth},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(jsonDecode(response.body));
      map = data.map<AnomalyBox>((item) => AnomalyBox.fromJson(item)).toList();
    }
    return map;
  }

  static makeAnomalyRequest(String title, String description) async {
    String tokenAuth = await getTokenAuth();


    final response = await http.post(
        Uri.parse(
            'https://steel-sequencer-385510.oa.r.appspot.com/rest/anomaly/create'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          HttpHeaders.authorizationHeader: tokenAuth
        },
        body: jsonEncode(<String, String>{
          "title": title,
          "description": description
        }));
    if (response.statusCode == 200) {
      return true;
    } else
      return false;
  }
/* static Future<bool> listAnomaly() async {
    print("LISTAR anomalias");
    bool res = await httpListAnomaly();

    return res;
  }

  static Future<bool> httpListAnomaly() async {
    final response = await http.post(
      Uri.parse('$appUrl/anomaly/list'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization':
            'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJmZWlqYW8iLCJpYXQiOjE2ODcyNTU4OTksImV4cCI6MTY4NzI1NTkwN30.StFRFTqudBUcNb0eo2iloHRqe9HrFvaXrL-GOal8S-U',
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      saveToSharedPreferences('anoList', jsonEncode(jsonResponse));
      print("RESPOSTA: $jsonResponse");

      return true;
    } else {
      return false;
    }
  }

  String? getAnomalyList() {
    //Checks if the browser's local storage has the key 'flutter.anoList'
    if (window.localStorage.containsKey('flutter.anoList')) {
      //If it does, then return the value of the key
      print(window.localStorage['flutter.anoList']);
      return window.localStorage['flutter.anoList'];
    } else {
      //If it does not, then return an empty string
      print("nada");
      return 'Não tem a key no armazenamento';
    }
  }

  static Future<bool> listNotifications() async {
    print("LISTAR Notificacoes");
    bool res = await httpListNotifications();

    return res;
  }

  static Future<bool> httpListNotifications() async {
    final response = await http.post(
      Uri.parse('$appUrl/notifications/list'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization':
            'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJmZWlqYW8iLCJpYXQiOjE2ODcyNTU4OTksImV4cCI6MTY4NzI1NTkwN30.StFRFTqudBUcNb0eo2iloHRqe9HrFvaXrL-GOal8S-U',
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      saveToSharedPreferences('notificationList', jsonEncode(jsonResponse));
      print("RESPOSTA: $jsonResponse");
      return true;
    } else {
      return false;
    }
  }

  String? getNotificationsList() {
    //Checks if the browser's local storage has the key 'flutter.notificationList'
    if (window.localStorage.containsKey('flutter.notificationList')) {
      //If it does, then return the value of the key
      print(window.localStorage['flutter.notificationList']);
      return window.localStorage['flutter.notificationList'];
    } else {
      //If it does not, then return an empty string
      print("nada");
      return 'Não tem a key no armazenamento';
    }
  } */
}



