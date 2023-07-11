import 'dart:convert';
import 'dart:io';

import '../../../anomalies/presentation/anomalyBox.dart';
import '../../../constants.dart';

class AnomaliesAuth {
  static get http => null;

  static Future<List<AnomalyBox>> getAnomaliesToAprove() async {
    List<AnomalyBox> map = [];
    String tokenAuth = await getTokenAuth();

    final response = await http.post(
      Uri.parse('$appUrl/list/anomalies'),
      headers: <String, String>{HttpHeaders.authorizationHeader: tokenAuth},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(jsonDecode(response.body));
      map = data.map<AnomalyBox>((item) => AnomalyBox.fromJson(item)).toList();
    }
    return map;
  }

  static Future<void> aproveAnomaly(String id) async {
    String tokenAuth = await getTokenAuth();

    final response = await http.post(
      Uri.parse('$appUrl/anomaly/aprove'),
      headers: <String, String>{HttpHeaders.authorizationHeader: tokenAuth},
      body: jsonEncode(<String, String>{
        'anomalyId': id,
      }),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      print("Anomaly aproved");
    } else {
      print("Anomaly not aproved");
    }
  }

  static Future<void> deleteAnomaly(String id) async {
    String tokenAuth = await getTokenAuth();

    final response = await http.post(
      Uri.parse('$appUrl/anomaly/delete'),
      headers: <String, String>{HttpHeaders.authorizationHeader: tokenAuth},
      body: jsonEncode(<String, String>{
        'anomalyId': id,
      }),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      print("Anomaly deleted");
    } else {
      print("Anomaly not deleted");
    }
  }
}
