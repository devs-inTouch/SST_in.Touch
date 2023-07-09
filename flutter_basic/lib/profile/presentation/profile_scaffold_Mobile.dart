import 'package:flutter/material.dart';
import 'package:flutter_basic/myAppBarMobile.dart';
import 'package:flutter_basic/profile/presentation/profileBox.dart';
import '../../bottomAppBarMobile.dart';
import '../../constants.dart';
import '../../eventCalendar.dart';
import '../../feeds/application/postRequests.dart';
import '../../myAppBar.dart';
import '../application/profleRequests.dart';

class ProfileScaffoldMobile extends StatefulWidget {
  final String name;
  final String imageAssetPath;
  final String role;
  final String year;
  final String nucleos;

  const ProfileScaffoldMobile({
    required this.name,
    required this.imageAssetPath,
    required this.role,
    required this.year,
    required this.nucleos,
  });

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfileScaffoldMobile> {
  List _posts = [];

  List userInfo = [];

  @override
  void initState() {
    super.initState();
    fetchData();
    fetchDataForPosts();
  }

  Future<void> fetchDataForPosts() async {
    final response = await PostRequests.getFeed();
    setState(() {
      _posts = response;
    });
    print("done this step");
  }

  Future<void> fetchData() async {
    final response = await ProfileRequests.getUserInfo();
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
                        ProfileBox(fem: fem, map: userInfo),
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
