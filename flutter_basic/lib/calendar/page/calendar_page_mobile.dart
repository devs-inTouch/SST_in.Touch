import 'package:flutter/material.dart';
import 'package:flutter_basic/calendar/page/event_editing_page.dart';
import 'package:flutter_basic/myAppBar.dart';
import 'package:flutter_basic/myAppBarMobile.dart';

import '../../bottomAppBarMobile.dart';
import '../widget/calendar_widget.dart';
//import 'page/event_editing_page.dart';

class CalendarPageMobile extends StatefulWidget {
  const CalendarPageMobile({super.key});

  @override
  State<CalendarPageMobile> createState() => CalendarPageState();
}

class CalendarPageState extends State<CalendarPageMobile> {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: MyAppBarMobile(),
    body: CalendarWidget(),
    floatingActionButton: FloatingActionButton(
      backgroundColor: const Color.fromARGB(255, 10, 2, 100),
      onPressed: () => Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) =>
                EventEditingPage(fromDate: DateTime.now())),
      ),
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    ),
    bottomNavigationBar: MyBottomAppBar(),
  );
}
