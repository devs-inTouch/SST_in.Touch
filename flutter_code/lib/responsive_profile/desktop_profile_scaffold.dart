import 'package:flutter/material.dart';
import 'package:flutter_basic/responsive_profile/viewUtils.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../constants.dart';
import '../eventCalendar.dart';

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
  bool _isEditing = false;
  List<Event> events = [];
  DateTime today = DateTime.now();
  Map<DateTime, List<Event>> eventsByDay = {};




  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fem = size.width / 1440; // 1440 is the reference width

    return Scaffold(
      appBar: myAppBar,
      drawer: myDrawer,
      backgroundColor: myBackground,
      body: Stack(
        children: [
          Container(
            width: size.width,
            height: size.height,

            child: Stack(
              children: [
                Positioned(
                  left: 1045 * fem,
                  top: 40 * fem,
                  child: SizedBox(
                    width: 160 * fem,
                    height: 160 * fem,
                    child: Container(
                      decoration: boxDecoration,
                      child: buildProfileImage(),
                    ),
                  ),
                ),

                //info do perfil
                Positioned(
                  // info
                  left: size.width * 0.05,
                  top: size.height * 0.05,
                  child: Container(
                    width: size.width * 0.5,
                    height: size.height * 0.8,
                    decoration: boxDecoration,
                    // topBar
                    child:buildProfileText(context),
                  ),
                ),
                //calendario
                Positioned(
                  // rectangle6JN6 (42:4)
                  left: size.width * 0.62,
                  top: size.height * 0.3,
                  child: Container(
                    width: size.width * 0.35,
                    height: size.height * 0.55,
                    decoration: boxDecoration,



                    child:buildCalendar(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
