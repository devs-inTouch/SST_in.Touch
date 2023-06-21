import 'dart:convert';
import 'package:http/http.dart' as http;

class AnomalyAuth {
  static const String appUrl =
      "https://steel-sequencer-385510.oa.r.appspot.com/rest";
/* 
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
} */

  static Future<bool> anomalyCreation(
      String username, String title, String description) async {
    print("aquiAnolmaly");
    bool res = await fetchAuthenticate(username, title, description);

    return res;
  }

  static Future<bool> fetchAuthenticate(
      String username, String title, String description) async {
    final response = await http.post(
      Uri.parse(
          'https://steel-sequencer-385510.oa.r.appspot.com/rest/anomaly/create'),
      headers: <String, String>{
        'Content-Type': 'application/json',
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
    }
  }
}
