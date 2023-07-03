import 'package:flutter/material.dart';

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


    return ListTile(
      title: Text(name),
      subtitle: Text(department+space+date+hour),
    );
  }
}
