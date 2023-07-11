import 'dart:convert';
import 'dart:io';
import 'package:flutter_basic/reservaSalas/presentation/salasBox.dart';
import 'package:http/http.dart' as http;
import '../../../constants.dart';
import '../../boxes/bookingBox.dart';
import '../../boxes/statsData.dart';
import '../../boxes/userActivateBox.dart';

class StatsValueAuth {
  static Future<StatsData?> getStats() async {
    StatsData data;
    String tokenAuth = await getTokenAuth();

    final response = await http.post(
      Uri.parse(
          'https://steel-sequencer-385510.oa.r.appspot.com/rest/list/stats'),
      headers: <String, String>{HttpHeaders.authorizationHeader: tokenAuth},
    );

    if (response.statusCode == 200) {
      data = StatsData.fromJson(jsonDecode(response.body));
      print(jsonDecode(response.body));
      return data;
    }
    return null;
  }
}
