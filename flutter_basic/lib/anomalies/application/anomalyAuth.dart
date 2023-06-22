import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:html';

class AnomalyAuth {
  static const String appUrl =
      "https://steel-sequencer-385510.oa.r.appspot.com/rest";

  static Future<bool> listAnomaly() async {
    print("LISTAR anomalias");
    bool res = await httpListAnomaly();

    return res;
  }

  static Future<void> saveToSharedPreferences(
      String key, String jsonValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, jsonValue);
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

  /* static const String appUrl =
      "https://steel-sequencer-385510.oa.r.appspot.com/rest";

  Future<String> createAnomaly(
      String username, String title, String description) async {
    final url = Uri.parse(appUrl + 'anomaly/create');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJmZWlqYW8iLCJpYXQiOjE2ODcyNTU4OTksImV4cCI6MTY4NzI1NTkwN30.StFRFTqudBUcNb0eo2iloHRqe9HrFvaXrL-GOal8S-U',
    };
    final body = jsonEncode({
      'username': username,
      'title': title,
      'description': description,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        print(jsonDecode(response.body));
        return jsonDecode(response.body);
      } else {
        // Handle the error case
        return 'An error occurred: ${response.statusCode}';
      }
    } catch (e) {
      return 'An error occurred: $e';
    }
  }

  static anomalyCreation(String username, String title, String description) {}
}

Future<bool> anomalyList(
    String username, String title, String description) async {
  print("aquiAnolmaly");
  bool res = await fetchAuthenticate(username, title, description);

  return res;
}

Future<bool> fetchAuthenticate(
    String username, String title, String description) async {
  final response = await http.post(
    Uri.parse(
        'https://steel-sequencer-385510.oa.r.appspot.com/rest/anomaly/list'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization':
          'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJmZWlqYW8iLCJpYXQiOjE2ODcyNTU4OTksImV4cCI6MTY4NzI1NTkwN30.StFRFTqudBUcNb0eo2iloHRqe9HrFvaXrL-GOal8S-U',
    },
    body: jsonEncode(<String, String>{
      "username": username,
      "title": title,
      "description": description,
    }),
  );
  print(response.statusCode);
  if (response.statusCode == 200) {
    final jsonResponse = jsonDecode(response.body);
    print("RESPOSTA: $jsonResponse");

    return true;
  } else {
    return false;
  } */










