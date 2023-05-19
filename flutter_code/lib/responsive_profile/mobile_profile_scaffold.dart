import 'package:flutter/material.dart';
import 'package:flutter_basic/responsive_profile/viewUtils.dart';
import 'package:flutter_basic/utils/my_box.dart';
import 'package:flutter_basic/utils/my_tile.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../constants.dart';
import '../eventCalendar.dart';

class MobileProfileScaffold extends StatefulWidget {
  final String name;
  final String imageAssetPath;
  final String role;
  final String year;
  final String nucleos;

  const MobileProfileScaffold({
    required this.name,
    required this.imageAssetPath,
    required this.role,
    required this.year,
    required this.nucleos,
  });

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<MobileProfileScaffold> {
  bool _isEditing = false;
  List<Event> events = [];
  DateTime today=DateTime.now();
  Map<DateTime, List<Event>> eventsByDay = {};



  @override
  Widget build(BuildContext context) {
    double fem = 1;

    return Scaffold(
      appBar: myAppBar,
      drawer: myDrawer,
      backgroundColor: Colors.white,

      body: Column(
        children: [
          SizedBox(height: 16),
          SizedBox(
            width: 150 * fem,
            height: 150 * fem,
            child: Container(
              decoration: boxDecoration,
              child:buildProfileImage(),
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: Container(
              height: 200*fem,
              width: 700 * fem,
              decoration: boxDecoration,
              child:buildProfileText(context),
            ),
          ),
          SizedBox(height: 16),

          SingleChildScrollView(
            child: Container(
              height: 120 * fem,
              width: 559 * fem,
              decoration: boxDecoration,
              child:buildCalendar(),
            ),
          ),
        ],
      ),
    );
  }
}
