import 'package:flutter/material.dart';

class NotificationBox extends StatelessWidget {
  final String message;
  final int creationDate;
  late DateTime date;

  NotificationBox({
    required this.message,
    required this.creationDate,
  });

  factory NotificationBox.fromJson(Map<String, dynamic> json) {
    return NotificationBox(
      message: json['message'],
      creationDate: json['creationDate'],
    );
  }

  @override
  Widget build(BuildContext context) {
    date = DateTime.fromMillisecondsSinceEpoch(creationDate);
    String dateTime = date.day.toString() +
        "-" +
        date.month.toString() +
        "-" +
        date.year.toString() +
        ", " +
        date.hour.toString() +
        ":" +
        date.minute.toString();

    return ListTile(
      title: Text(message),
      subtitle: Text(dateTime),
    );
  }
}
