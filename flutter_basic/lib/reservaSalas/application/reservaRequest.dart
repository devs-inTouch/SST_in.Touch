import 'dart:convert';
import 'dart:io';
import 'package:flutter_basic/reservaSalas/presentation/salasBox.dart';
import 'package:http/http.dart' as http;
import '../../constants.dart';

class ReservaAuth {
  static Future<List<SalasBox>> getRoomsList(String date, String hour) async {
    List<SalasBox> map = [];
    String tokenAuth = await getTokenAuth();

    final response = await http.post(
      Uri.parse(
          'https://steel-sequencer-385510.oa.r.appspot.com/rest/reservation/getroomdate'),
      headers: <String, String>{
        HttpHeaders.authorizationHeader: tokenAuth,
      },
      body: {
        'date': date,
        'hour': hour,
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(jsonDecode(response.body));
      map = data.map<SalasBox>((item) => SalasBox.fromJson(item)).toList();
    }
    return map;
  }
}