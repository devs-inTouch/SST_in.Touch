import 'package:flutter/material.dart';
import 'package:flutter_basic/calendar/model/event.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../model/event_data_source.dart';
import '../page/calendar_day_page.dart';

import '../provider/events_request.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  State<StatefulWidget> createState() => CalendarWidgetState();
}

class CalendarWidgetState extends State<CalendarWidget> {
  List<Event> events = [];

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
    print("done this Calendar step");
  }

  @override
  Widget build(BuildContext context) {
    return SfCalendar(
      view: CalendarView.month,
      dataSource: EventDataSource(events),
      initialSelectedDate: DateTime.now(),
      //cellBorderColor: Colors.transparent,
      onTap: (details) {
        List<Event> dayEvents = getEventsOfDay(details.date);
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => CalendarDayPage(dayEvents, details.date!)),
        );
      },
    );
  }

  List<Event> getEventsOfDay(DateTime? date) {
    if (date != null) {
      final filteredEvents = events
          .where((event) =>
              event.from.year == date.year &&
              event.from.month == date.month &&
              event.from.day == date.day)
          .toList();

      return filteredEvents;
    }
    return [];
  }
}
