import 'package:flutter/material.dart';

class AnomalyBox extends StatelessWidget {
  final String username;
  final String type;
  final String description;

  AnomalyBox({
    required this.username,
    required this.type,
    required this.description,
  });

  factory AnomalyBox.fromJson(Map<String, dynamic> json) {
    return AnomalyBox(
      username: json['username'],
      type: json['type'],
      description: json['description'],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Container(
                  color: Colors.blueAccent[200],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(username),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(type),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(description),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
