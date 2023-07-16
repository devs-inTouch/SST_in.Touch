import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_basic/myAppBarMobile.dart';
import 'package:flutter_basic/profile/presentation/profileBox.dart';
import 'package:flutter_basic/profile/presentation/profileBoxMobile.dart';
import '../../bottomAppBarMobile.dart';
import '../../constants.dart';
import '../../eventCalendar.dart';
import '../../feeds/application/postRequests.dart';
import '../../myAppBar.dart';
import '../application/profleRequests.dart';

class ProfileScaffoldMobile extends StatefulWidget {
  final String name;


  const ProfileScaffoldMobile({
    required this.name,

  });

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfileScaffoldMobile> {
  List _posts = [];

  List userInfo = [];

  String userWanted = '';

  bool myProfile = true;



  @override
  void initState() {
    super.initState();
    fetchUserWanted();
    print("object " + userWanted);

  }

  Future<void> fetchUserWanted() async {
    final response = await ProfileRequests.getUsername();
    if(widget.name == '') {
      setState(() {
        userWanted = response;
      });
    } else {
      setState(() {
        userWanted = widget.name;
        myProfile = false;
      });
    }
    if(response.isNotEmpty) {
      fetchData();
      fetchDataForPosts();
    }
  }
  //mudar
  Future<void> fetchDataForPosts() async {
    final response = await PostRequests.getPersonalFeed(userWanted);
    setState(() {
      _posts = response;
    });
    print("done this step");
  }

  Future<void> fetchData() async {
    List response;
    print("USER " + userWanted);
    response = await ProfileRequests.getUserInfo(userWanted);

    setState(() {
      userInfo = response;
    });
    print("ola");
    print(userInfo);
  }

  List<Event> events = [];
  DateTime today = DateTime.now();
  Map<DateTime, List<Event>> eventsByDay = {};
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fem = size.width / 1440;

    return Scaffold(
      appBar: MyAppBarMobile(),
      backgroundColor: myBackground,
      body: userInfo.isNotEmpty
          ? Stack(
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.white),
            width: size.width,
            height: size.height,
            child: Scrollbar(
              child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        ProfileBoxMobile(
                          fem: fem,
                          myProfile: myProfile,
                          name: utf8.decode(userInfo[4].codeUnits),
                          department: utf8.decode(userInfo[1].codeUnits),
                          email: utf8.decode(userInfo[3].codeUnits),
                          description: utf8.decode(userInfo[2].codeUnits),
                          follow: 'Seguir',
                        ),
                        SizedBox(height: 10),
                        Container(
                            width: 650,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: _posts.length,
                              itemBuilder: (BuildContext context, int index) {
                                final post = _posts[index];
                                post.setFem(fem);
                                return post;
                              },
                            ))
                      ])),
            ),
          ),
        ],
      )
          : LinearProgressIndicator(),
      bottomNavigationBar: MyBottomAppBar(),

    );
  }

}
