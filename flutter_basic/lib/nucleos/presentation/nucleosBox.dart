import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants.dart';
import '../../myAppBar.dart';

class NucleosBox extends StatelessWidget {
  final String title;
  final String description;
  final String faceUrl;
  final String instaUrl;
  final String twitterUrl;

  NucleosBox({
    required this.title,
    required this.description,
    required this.faceUrl,
    required this.instaUrl,
    required this.twitterUrl,
  });

  factory NucleosBox.fromJson(Map<String, dynamic> json) {
    return NucleosBox(
      title: json['title'],
      description: json['description'],
      faceUrl: json['faceUrl'],
      instaUrl: json['instaUrl'],
      twitterUrl: json['twitterUrl'],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 400,
      color: Colors.grey[300],
      child: Column(
        children: [
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 180,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.blueAccent[200],
                ),
                child: Center(
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Scrollbar(
                child: Container(
                  width: 200,
                  height: 130,
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                  ),
                  child: Center(
                    child: Text(
                      description,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: 200,
                height: 130,
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: GestureDetector(
                        onTap: () {

                          launch("https://$faceUrl"); // Add the protocol here
                        },
                        child: Text(
                          "Facebook",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: GestureDetector(
                        onTap: () {

                          launch("https://$instaUrl"); // Add the protocol here
                        },
                        child: Text(
                          "Instagram",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: GestureDetector(
                        onTap: () {

                          launch("https://$twitterUrl"); // Add the protocol here
                        },
                        child: Text(
                          "Para saber mais",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
