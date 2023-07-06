import 'package:flutter/material.dart';
import 'package:flutter_basic/calendar/model/event.dart';
import 'package:flutter_basic/myAppBar.dart';
import '../widget/calendar_day_widget.dart';
import 'event_editing_page.dart';

class CalendarDayPage extends StatefulWidget {
  final List<Event> events;
  final DateTime selectedDate;

  CalendarDayPage(this.events, this.selectedDate);

  @override
  _CalendarDayPageState createState() => _CalendarDayPageState();
}

class _CalendarDayPageState extends State<CalendarDayPage> {
  List<Event> get events => widget.events;
  DateTime get selectedDate => widget.selectedDate;
  @override
  Widget build(BuildContext context) {
    print("_____object_____");
    print(events);
    return Scaffold(
      appBar: MyAppBar(),
      body: CalendarDayWidget(
        events: events,
        fromDate: selectedDate,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 10, 2, 100),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => EventEditingPage(
                    fromDate: selectedDate,
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
