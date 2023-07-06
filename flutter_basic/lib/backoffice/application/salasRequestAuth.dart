import 'dart:convert';
import 'dart:io';
import 'package:flutter_basic/reservaSalas/presentation/salasBox.dart';
import 'package:http/http.dart' as http;
import '../../constants.dart';
import '../presentation/bookingBox.dart';

class SalasRequestAuth {
  static Future<List<BookingBox>> getBookingList() async {
    List<BookingBox> map = [];
    String tokenAuth = await getTokenAuth();

    final response = await http.post(
        Uri.parse(
            'https://steel-sequencer-385510.oa.r.appspot.com/rest/reservation/listallbookings'),
        headers: <String, String>{HttpHeaders.authorizationHeader: tokenAuth},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(jsonDecode(response.body));
      map = data.map<BookingBox>((item) => BookingBox.fromJson(item)).toList();
    }
    return map;
  }
}
