import 'dart:convert';
import 'dart:io';
import 'package:flutter_basic/reservaSalas/presentation/salasBox.dart';
import 'package:http/http.dart' as http;
import '../../constants.dart';
import '../presentation/boxes/bookingBox.dart';

class ActivateUsersAuth {
  static Future<List<BookingBox>> getUsersToActivate() async {
    List<BookingBox> map = [];
    String tokenAuth = await getTokenAuth();

    final response = await http.post(
      Uri.parse(
          'https://steel-sequencer-385510.oa.r.appspot.com/rest/list/unactivated'),
      headers: <String, String>{HttpHeaders.authorizationHeader: tokenAuth},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(jsonDecode(response.body));
      map = data.map<BookingBox>((item) => BookingBox.fromJson(item)).toList();
    }
    return map;
  }

  static Future<void> approveUser() async {
    List<BookingBox> map = [];
    String tokenAuth = await getTokenAuth();

    final response = await http.post(
      Uri.parse(
          'https://steel-sequencer-385510.oa.r.appspot.com/rest/userActivation/activate'),
      headers: <String, String>{HttpHeaders.authorizationHeader: tokenAuth},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(jsonDecode(response.body));
      map = data.map<BookingBox>((item) => BookingBox.fromJson(item)).toList();
    }
  }


  static Future<void> denyReservation() async {
    List<BookingBox> map = [];
    String tokenAuth = await getTokenAuth();

    final response = await http.post(
      Uri.parse(
          'https://steel-sequencer-385510.oa.r.appspot.com/rest/userActivation/notapprove'),
      headers: <String, String>{HttpHeaders.authorizationHeader: tokenAuth},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(jsonDecode(response.body));
      map = data.map<BookingBox>((item) => BookingBox.fromJson(item)).toList();
    }
  }
}
