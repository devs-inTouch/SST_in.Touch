import 'package:flutter/material.dart';
import 'package:flutter_basic/calendar/model/event.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../model/event_data_source.dart';

import '../page/event_viewing_page.dart';
import '../provider/events_request.dart';

class CalendarScheduleWidget extends StatefulWidget {
  const CalendarScheduleWidget({super.key});

  @override
  State<StatefulWidget> createState() => CalendarScheduleWidgetState();
}

class CalendarScheduleWidgetState extends State<CalendarScheduleWidget> {
  List<Event> events = [];

  List<Event> get getEvents => events;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await EventRequests.getCalendarEvents();
    setState(() {
      events = response;
    });
    print("-----done this Calendar step-----");
  }

  @override
  Widget build(BuildContext context) {
    return SfCalendar(
      view: CalendarView.schedule,
      dataSource: EventDataSource(events),
      initialSelectedDate: DateTime.now(),
      cellBorderColor: Colors.grey,
      backgroundColor: Color.fromARGB(118, 110, 110, 110),
      onTap: (details) {
        if (details.appointments == null) return;
        final event = details.appointments!.first;

        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => EventViewingPage(event: event),
        ));
      },
    );
  }
}
