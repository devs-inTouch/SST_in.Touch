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
  }@override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.blueAccent[200],
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.blue[900]!),
      ),
      child: Container(
        child: ListTile(
          title: Text('Nome: $name'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Departamento: $department'),
              Text('Número de alunos: $space'),
              Text('Data: $date'),
              Text('Hora: $hour'),
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
            style: ElevatedButton.styleFrom(
              primary: Colors.blueAccent[200],
              onPrimary: Colors.white,
              textStyle: TextStyle(fontWeight: FontWeight.bold),
            ),
            child: Text('RESERVAR SALA'),
          ),
        ),
      ),
    );
  }

}
