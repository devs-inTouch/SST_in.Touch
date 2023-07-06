
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookingBox  extends StatelessWidget {
  final String username;
  final String room;
  final String department;
  final int numberStudents;
  final String date;
  final String hour;

  BookingBox({
    required this.username,
    required this.room,
    required this.department,
    required this.numberStudents,
    required this.date,
    required this.hour,
  });

  factory BookingBox.fromJson(Map<String, dynamic> json) {
    return BookingBox(
      username: json['username'],
      room: json['room'],
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
            Text('Room: $room'),
            Text('Department: $department'),
            Text('Number of Students: $numberStudents'),
            Text('Date: $date'),
            Text('Hour: $hour'),
          ],
        ),
      ),
    );
  }
}
