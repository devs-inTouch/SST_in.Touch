import 'package:flutter/material.dart';
import 'package:flutter_basic/responsive_profile/presentation/viewUtils.dart';
import '../../constants.dart';
import '../../eventCalendar.dart';
import '../../feeds/postBox.dart';
import '../../myAppBar.dart';

class DesktopProfileScaffold extends StatefulWidget {
  final String name;
  final String imageAssetPath;
  final String role;
  final String year;
  final String nucleos;

  const DesktopProfileScaffold({
    required this.name,
    required this.imageAssetPath,
    required this.role,
    required this.year,
    required this.nucleos,
  });

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<DesktopProfileScaffold> {

  List _posts = [
      "post 1","post 2", "post 3", "post 4"
  ];

  List<Event> events = [];
  DateTime today = DateTime.now();
  Map<DateTime, List<Event>> eventsByDay = {};




  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fem = size.width / 1440; // 1440 is the reference width

    return Scaffold(
      appBar: MyAppBar(),
      drawer: myDrawer,
      backgroundColor: myBackground,
      body: Stack(
        children: [

            Container(
              decoration: BoxDecoration(
                color: Colors.green
              ),
            width: size.width,
            height: size.height,

            child: Scrollbar(
              child: SingleChildScrollView(
                 child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 10,),
                      Container(
                          height: 300,
                          width: 650,
                          decoration: BoxDecoration(
                            color: Colors.red
                          ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: 650,
                        child:ListView.builder(
                        shrinkWrap: true,
                        itemCount: _posts.length,
                        itemBuilder: (BuildContext context, int index) {
                            return PostBox(text:_posts[index]);
                        },

                       )
                      )
                    ]
                  )


            ),
          ),),
        ],
      ),
    );
  }
}
