import 'package:flutter/material.dart';
import 'package:flutter_basic/calendar/model/event.dart';
import 'package:flutter_basic/myAppBar.dart';
import '../widget/calendar_day_widget.dart';
import 'event_editing_page.dart';

class CalendarDayPage extends StatefulWidget {
  final List<Event> events;

  CalendarDayPage(this.events);

  @override
  _CalendarDayPageState createState() => _CalendarDayPageState();
}

class _CalendarDayPageState extends State<CalendarDayPage> {
  List<Event> get events => widget.events;
  @override
  Widget build(BuildContext context) {
    print("_____object_____");
    print(events);
    return Scaffold(
      appBar: MyAppBar(),
      body: CalendarDayWidget(
        events: events,
        fromDate: events[0].from,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 10, 2, 100),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => EventEditingPage(
                    fromDate: events[0].from,
                  )),
        ),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
