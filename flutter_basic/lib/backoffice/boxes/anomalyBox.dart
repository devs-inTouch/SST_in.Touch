import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basic/anomalies/application/anomalyAuth.dart';
import 'package:flutter_basic/backoffice/application/salasRequestAuth.dart';

import '../anomalies/application/anomaliesAuth.dart';

class AnomalyBoxBO extends StatelessWidget {
  final String username;
  final String type;
  final String description;

  AnomalyBoxBO({
    required this.username,
    required this.type,
    required this.description,
  });

  factory AnomalyBoxBO.fromJson(Map<String, dynamic> json) {
    return AnomalyBoxBO(
      username: json['username'],
      type: json['type'],
      description: json['description'],
    );
  }
  @override
  Widget build(BuildContext context) {
    final borderColor = Colors.blueAccent[200]; // Fallback color if blueAccent[200] is null


    return Container(
      decoration: BoxDecoration(
        color: borderColor, // Setting background color to borderColor
        border: Border.all(color: Colors.blueGrey),// Adding border
        borderRadius: BorderRadius.circular(8.0), // Adding border radius
      ),
      padding: EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(
          'Username: $username',
          style: TextStyle(
            color: Colors.white, // Setting text color to white
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4.0), // Adding padding between texts
            Text(
              'Tipo: $type',
              style: TextStyle(color: Colors.white),
            ),
            Text(
              'Descrição: $description',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                AnomaliesAuth.approveAnomaly(username);
                print("anomaly aproved");

              },
            ),
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                AnomaliesAuth.deleteAnomaly(username);
                print("anomaly denied");

              },
            ),
          ],
        ),
      ),
    );
  }
}
