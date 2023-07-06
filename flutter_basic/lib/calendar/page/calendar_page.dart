import 'package:flutter/material.dart';
import 'package:flutter_basic/calendar/page/event_editing_page.dart';
import 'package:flutter_basic/calendar/provider/event_provider.dart';
import 'package:flutter_basic/myAppBar.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../model/event.dart';
import '../provider/events_request.dart';
import '../widget/calendar_widget.dart';
//import 'page/event_editing_page.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => CalendarPageState();
}

class CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: MyAppBar(),
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
      );
}
