import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';

class PostBox extends StatelessWidget{

  final String postIdentifier;
  final String username;
  final String description;
  final String mediaUrl;
  final int ups;
  final int downs;
  final int creationDate;
  double fem = 0.0;
  late DateTime date;


  PostBox({
    required this.postIdentifier,
    required this.username,
    required this.description,
    required this.mediaUrl,
    required this.ups,
    required this.downs,
    required this.creationDate,

  });



  factory PostBox.fromJson(Map<String, dynamic> json) {
    return PostBox(
      postIdentifier: json['postIdentifier'],
      username: json['username'],
      description: json['description'],
      mediaUrl: json['mediaUrl'],
      ups: json['ups'],
      downs: json['downs'],
      creationDate: json['creationDate'],
    );
  }

  void setFem(double value) {
    fem = value;
  }

  

  @override
  Widget build(BuildContext context) {

    date = DateTime.fromMillisecondsSinceEpoch(creationDate);
    String dateTime = date.day.toString() + "-" + date.month.toString() + "-" + date.year.toString() + ", " + date.hour.toString()+":"+date.minute.toString();

    return Padding(padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Container(

        width: 650* fem,
        decoration: BoxDecoration(
          color: Color.fromRGBO(217,217,217,1)
        ), child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
          Padding(
            padding: EdgeInsets.all(6.0),
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.white
              ),
            )
          ),
              Text(
                username,
                style: TextStyle(
                  fontSize: 15
                ),
              ),

              Spacer(),
          Padding(
            padding: EdgeInsets.only(right: 30.0, top: 10.0) ,
            child: Text(
                dateTime,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14
              ),
            ),
          )]),
          Padding(
            padding: EdgeInsets.only(top:10.0,bottom: 10.0),
            child: Text(
              description,
             textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 22
              ),

            ),
          ),
          Center(
          child:Padding(padding: EdgeInsets.all(10.0),
          child:ImageNetwork(image: 'https://firebasestorage.googleapis.com/v0/b/steel-sequencer-385510.appspot.com/o/cat2.jpg?alt=media&token=81c06104-7b39-40e4-add8-b6dc88da2d8f',
            height: 300*fem, width: 300*fem,

          ))),
          Row(
          children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: IconButton(onPressed: () {  }
              , icon: Icon(Icons.arrow_upward_sharp),
              iconSize: 30,


            )
          ), IconButton(onPressed: () {  }
              , icon: Icon(Icons.arrow_downward_sharp),
              iconSize: 30,


            )
          ])
        ],
      )
     )
    );
  }

}

class ExpandedImageScreen extends StatelessWidget {
  final String imagePath;

  ExpandedImageScreen({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Hero(
          tag: imagePath,
          child: Image.network(imagePath),
        ),
      ),
    );
  }
}