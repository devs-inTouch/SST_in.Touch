import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basic/anomalies/application/anomalyAuth.dart';
import 'package:flutter_basic/backoffice/application/salasRequestAuth.dart';

import '../anomalies/application/anomaliesAuth.dart';
import '../presentation/responsive_backOffice.dart';

class AnomalyBoxBO extends StatelessWidget {
  final String id;
  final String username;
  final String type;
  final String description;

  AnomalyBoxBO({
    required this.id,
    required this.username,
    required this.type,
    required this.description,
  });

  factory AnomalyBoxBO.fromJson(Map<String, dynamic> json) {
    return AnomalyBoxBO(
      id: json['id'],
      username: json['username'],
      type: json['type'],
      description: json['description'],
    );
  }
  @override
  Widget build(BuildContext context) {
    final borderColor =
        Colors.blueAccent[200];

    return Container(
      decoration: BoxDecoration(
        color: borderColor,
        border: Border.all(color: Colors.blueGrey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(
          'Username: $username',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4.0),
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
                AnomaliesAuth.approveAnomaly(id);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ResponsiveBackOffice()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                AnomaliesAuth.deleteAnomaly(id);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ResponsiveBackOffice()),
                );
              },

            ),
          ],
        ),
      ),
    );
  }
}
