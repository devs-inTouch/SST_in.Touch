import 'dart:convert';
import 'dart:io';
import 'package:flutter_basic/reservaSalas/presentation/salasBox.dart';
import 'package:http/http.dart' as http;
import '../../constants.dart';
import '../boxes/bookingBox.dart';
import '../boxes/statsData.dart';
import '../boxes/userRoleBox.dart';

class StatsValueAuth {
  static Future<List<StatsData>> getStats() async {
    List<StatsData> map = [];
    String tokenAuth = await getTokenAuth();

    final response = await http.post(
      Uri.parse(
          'https://steel-sequencer-385510.oa.r.appspot.com/rest/list/stats'),
      headers: <String, String>{HttpHeaders.authorizationHeader: tokenAuth},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(jsonDecode(response.body));
      map = data.map<StatsData>((item) => StatsData.fromJson(item)).toList();
    }
    return map;
  }
}
