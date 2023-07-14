import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basic/backoffice/application/salasRequestAuth.dart';
import 'package:flutter_basic/backoffice/presentation/pedidosReservaSalaPage.dart';

import '../presentation/responsive_backOffice.dart';

class BookingBox extends StatelessWidget {
  final String username;
  final String name;
  final String department;
  final String numberStudents;
  final String date;
  final String hour;

  BookingBox({
    required this.username,
    required this.name,
    required this.department,
    required this.numberStudents,
    required this.date,
    required this.hour,
  });

  factory BookingBox.fromJson(Map<String, dynamic> json) {
    return BookingBox(
      username: json['username'],
      name: json['name'],
      department: json['department'],
      numberStudents: json['numberStudents'],
      date: json['date'],
      hour: json['hour'],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        title: Text('Username: $username'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Room: $name'),
            Text('Department: $department'),
            Text('Number of Students: $numberStudents'),
            Text('Date: $date'),
            Text('Hour: $hour'),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.check),
              onPressed: ()  {
                 SalasRequestAuth.approveReservation(
                  username,
                  name,
                  department,
                  numberStudents,
                  date,
                  hour,
                );
                 Navigator.push(
                   context,
                   MaterialPageRoute(
                       builder: (context) => PedidoReservaSalaPage()),
                 );
              },
            ),
            IconButton(
              icon: Icon(Icons.close),
              onPressed: ()  {
                 SalasRequestAuth.denyReservation(
                  username,
                  name,
                  department,
                  numberStudents,
                  date,
                  hour,
                );
                 Navigator.push(
                   context,
                   MaterialPageRoute(
                       builder: (context) => PedidoReservaSalaPage()),
                 );
              },
            ),
          ],
        ),
      ),
    );
  }
}