import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../anomalies/presentation/anomalyBox.dart';
import '../../../constants.dart';
import '../../boxes/anomalyBox.dart';

class AnomaliesAuth {
  static Future<List<AnomalyBoxBO>> getAnomaliesToAprove() async {
    List<AnomalyBoxBO> map = [];
    String tokenAuth = await getTokenAuth();

    final response = await http.post(
      Uri.parse('$appUrl/anomaly/listnotapproved'),
      headers: <String, String>{HttpHeaders.authorizationHeader: tokenAuth},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(jsonDecode(response.body));
      map = data
          .map<AnomalyBoxBO>((item) => AnomalyBoxBO.fromJson(item))
          .toList();
    }
    return map;
  }

  static Future<void> approveAnomaly(String id) async {
    print(id);
    String tokenAuth = await getTokenAuth();

    final response = await http.post(
      Uri.parse('$appUrl/anomaly/approve'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: tokenAuth
      },
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
    print(id);
    String tokenAuth = await getTokenAuth();

    final response = await http.post(
      Uri.parse('$appUrl/anomaly/delete'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: tokenAuth
      },
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
