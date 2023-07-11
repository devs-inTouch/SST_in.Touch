import 'package:flutter/material.dart';
import 'package:flutter_basic/profile/application/profleRequests.dart';

import '../application/reservaRequest.dart';

class SalasBox extends StatelessWidget {
  final String name;
  final String department;
  final String space;
  final String date;
  final String hour;

  SalasBox({
    required this.name,
    required this.department,
    required this.space,
    required this.date,
    required this.hour,
  });

  factory SalasBox.fromJson(Map<String, dynamic> json) {
    return SalasBox(
      name: json['name'],
      department: json['department'],
      space: json['space'],
      date: json['date'],
      hour: json['hour'],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        title: Text('name: $name'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Department: $department'),
            Text('Number of Students: $space'),
            Text('Date: $date'),
            Text('Hour: $hour'),
          ],
        ),
        trailing: ElevatedButton(
          onPressed: () {
            String username = ProfileRequests.getUsername() as String;
            ReservaAuth.bookRoom(
              username,
              name,
              department,
              space,
              date,
              hour,
            );
            print("salaaa");
          },
          child: Text('Reservar Sala'),
        ),
      ),
    );
  }
}
