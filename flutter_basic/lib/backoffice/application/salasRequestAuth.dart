import 'dart:convert';
import 'dart:io';
import 'package:flutter_basic/reservaSalas/presentation/salasBox.dart';
import 'package:http/http.dart' as http;
import '../../constants.dart';
import '../boxes/bookingBox.dart';

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

  static Future<void> approveReservation(
      String username, String name, String department, String numberStudents, String date, String hour) async {
    List<BookingBox> map = [];
    String tokenAuth = await getTokenAuth();

    final response = await http.post(
      Uri.parse(
          'https://steel-sequencer-385510.oa.r.appspot.com/rest/reservation/approve'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: tokenAuth
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'name': name,
        'department': department,
        'numberStudents': numberStudents,
        'date': date,
        'hour': hour,
      }),
    );

    print(response.statusCode);
    if (response.statusCode == 200) {
      print("Reservation approved");
    } else {
      print("Error");
    }
  }

  static Future<void> denyReservation(
      String username, String name, String department, String numberStudents, String date, String hour) async {
    String tokenAuth = await getTokenAuth();

    final response = await http.post(
      Uri.parse(
          'https://steel-sequencer-385510.oa.r.appspot.com/rest/reservation/notapprove'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: tokenAuth
      },
      body: jsonEncode(<String, dynamic>{
        'username': username,
        'name': name,
        'department': department,
        'numberStudents': numberStudents,
        'date': date,
        'hour': hour,
      }),
    );

    print(response.statusCode);
    if (response.statusCode == 200) {
      print("Reservation denied");
    } else {
      print("Error");
    }
  }
}