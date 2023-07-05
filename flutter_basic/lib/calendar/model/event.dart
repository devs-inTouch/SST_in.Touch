import 'package:flutter/material.dart';

class Event {
  final String id;
  final String title;
  final String description;
  final DateTime from;
  final DateTime to;
  final Color backgroundColor;
  final bool isAllDay;
  final bool isPublic;

  const Event({
    required this.id,
    required this.title,
    required this.description,
    required this.from,
    required this.to,
    required this.backgroundColor,
    this.isAllDay = false,
    this.isPublic = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'from': from.toString(),
      'to': to.toString(),
      'backgroundColor': backgroundColor.value,
      'isAllDay': isAllDay,
      'isPublic': isPublic,
    };
  }

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      from: DateTime.parse(json['from']),
      to: DateTime.parse(json['to']),
      backgroundColor: Color(int.parse(json['backgroundColor'])),
      isAllDay: json['isAllDay'],
      isPublic: json['isPublic'],
    );
  }
}
