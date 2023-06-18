import 'dart:convert';
import 'package:http/http.dart' as http;

class AnomalyPost{

  static Future<bool> anomalyCreation(String username,String title,String description) async {
    print("aqui");
    bool res = await fetchAuthenticate(username, title, description);

    return res;

  }


  static Future<bool> fetchAuthenticate(String username, String title, String description) async {

    final response = await http.post(
      Uri.parse('https://steel-sequencer-385510.oa.r.appspot.com/rest/anomaly/create'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        "username":username,
        "title":title,
        "description":description,

      }),
    );
    print(response.statusCode);
    if(response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      print("RESPOSTA: $jsonResponse");

      return true;
    } else {
      return false;
    }
  }

}