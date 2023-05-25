import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../eventCalendar.dart';
import '../../myAppBar.dart';

class DesktopProfileScaffold extends StatefulWidget {
  final String name;
  final String imageAssetPath;
  final String role;
  final String year;
  final String nucleos;

  const DesktopProfileScaffold({super.key, 
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
  final bool _isEditing = false;
  List<Event> events = [];
  DateTime today = DateTime.now();
  Map<DateTime, List<Event>> eventsByDay = {};




  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fem = size.width / 1440; // 1440 is the reference width

    return Scaffold(
      appBar: const MyAppBar(),
      drawer: myDrawer,
      backgroundColor: myBackground,
      body: Stack(
        children: [
          Scrollbar(
            child: SingleChildScrollView(
            child: SizedBox(
            width: size.width,
            height: size.height,

            child:
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 200,),
                      Container(
                          height: 350,
                          width: 550,
                          decoration: const BoxDecoration(
                            color: Colors.red
                          ),
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
