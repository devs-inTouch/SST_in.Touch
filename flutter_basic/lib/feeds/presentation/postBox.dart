import 'package:flutter/material.dart';
import 'package:flutter_basic/constants.dart';
import 'package:image_network/image_network.dart';
import 'package:flutter_basic/feeds/application/postRequests.dart';



class PostBox extends StatefulWidget {
  final String postIdentifier;
  final String username;
  final String description;
  final String mediaUrl;
  final List ups;
  final List downs;
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

  @override
  State<PostBox> createState() => BoxState();



  void setFem(double value) {
    fem = value;
  }
}

class BoxState extends State<PostBox> {

  bool isUp = false;
  bool isDown = false;
  int numUps = 0;
  int numDowns = 0;
  Color upButtonColor = Colors.white;
  Color downButtonColor = Colors.white;

  @override
  void initState() {
    super.initState();
    fetchData(widget.postIdentifier);
  }

  fetchData(String postID) async {
    List ups = await PostRequests.checkUps(postID);
    List downs = await PostRequests.checkDowns(postID);
    setState(() {
      numUps = int.parse(ups[1]);
      numDowns = int.parse(downs[1]);
      isUp = ups[0].toLowerCase() == "true";
      isDown = downs[0].toLowerCase() == "true";
      if(isUp) {
        upButtonColor = Colors.blue;
        downButtonColor = Colors.white;
      } else if(isDown) {
        upButtonColor = Colors.white;
        downButtonColor = Colors.blue;
      } else if(!isDown && !isUp){
        upButtonColor = Colors.white;
        downButtonColor = Colors.white;
      }
    });
  }


  handleUp(String postID) async {
    bool done = await PostRequests.clickedUp(postID);
    if(done) {
      fetchData(postID);
    }
  }

  handleDown(String postID) async{
    bool done = await PostRequests.clickedDown(postID);
    if(done) {
      fetchData(postID);
    }
  }

  @override
  Widget build(BuildContext context) {
    widget.date = DateTime.fromMillisecondsSinceEpoch(widget.creationDate);
    String dateTime = widget.date.day.toString() +
        "-" +
        widget.date.month.toString() +
        "-" +
        widget.date.year.toString() +
        ", " +
        widget.date.hour.toString() +
        ":" +
        widget.date.minute.toString();

    return Padding(
        padding: EdgeInsets.fromLTRB(10.0, 4.0,10.0, 4.0),
        child: Container(
            width: 650 * widget.fem,
            decoration: BoxDecoration(color: Color.fromRGBO(217, 217, 217, 1)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(children: [
                  Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(color: Colors.white),
                      )),
                  Text(
                    widget.username,
                    style: TextStyle(fontSize: 15),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.only(right: 30.0, top: 10.0),
                    child: Text(
                      dateTime,
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  )
                ]),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Text(
                    widget.description,
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 22),
                  ),
                ),
                Center(
                    child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: ImageNetwork(
                          image:
                          widget.mediaUrl,
                          height: 300 ,
                          width: 300 ,
                        ))),
                Row(children: [
                  Padding(
                      padding: EdgeInsets.all(10.0),
                      child: IconButton(
                        onPressed: () { handleUp(widget.postIdentifier);},
                        icon: Icon(Icons.arrow_upward_sharp),
                        color: upButtonColor,
                        iconSize: 30,
                      )),
                  IconButton(
                    onPressed: () { handleDown(widget.postIdentifier);},
                    icon: Icon(Icons.arrow_downward_sharp),
                    color: downButtonColor,
                    iconSize: 30,
                  )
                ])
              ],
            )));
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
