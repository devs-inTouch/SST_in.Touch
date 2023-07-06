import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:url_launcher/url_launcher.dart';


class NewsBox extends StatelessWidget {
  final String title;
  final String description;
  final String mediaUrl;
  final int creationDate;
  double fem = 0.0;
  late DateTime date;

  NewsBox({
    required this.title,
    required this.description,
    required this.mediaUrl,
    required this.creationDate,
  });

  factory NewsBox.fromJson(Map<String, dynamic> json) {
    return NewsBox(
      title: json['title'],
      description: json['description'],
      mediaUrl: json['mediaUrl'],
      creationDate: json['creationDate'],
    );
  }

  void setFem(double value) {
    fem = value;
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

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        width: 800 * fem, // Adjust the width as per your preference
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.black.withOpacity(0.5),
            width: 1.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.blueAccent[100],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    dateTime,
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                description,
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 16),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: GestureDetector(
                  onTap: () {
                    // Handle the click event here
                    launch(mediaUrl);
                  },
                  child: Text(
                    "Clique aqui para mais informações",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      decoration: TextDecoration.underline, // Add underline to indicate it's clickable
                      color: Colors.blue, // Optionally change the text color to blue
                    ),
                  ),
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }

}
