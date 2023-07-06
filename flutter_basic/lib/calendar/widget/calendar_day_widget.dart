import 'package:flutter/material.dart';
import 'package:flutter_basic/calendar/model/event.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../model/event_data_source.dart';
import '../page/event_viewing_page.dart';
import '../provider/event_provider.dart';

class CalendarDayWidget extends StatefulWidget {
  final DateTime fromDate;
  final List<Event> events;
  const CalendarDayWidget({
    Key? key,
    required this.events,
    required this.fromDate,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() => CalendarDayWidgetState();
}

class CalendarDayWidgetState extends State<CalendarDayWidget> {
  @override
  Widget build(BuildContext context) {
    final selectedDate = widget.fromDate;
    final events = widget.events;
    return SfCalendar(
      view: CalendarView.day,
      dataSource: EventDataSource(events),
      initialDisplayDate: selectedDate,
      appointmentBuilder: appointmentBuilder,
      headerHeight: 0,
      //cellBorderColor: Colors.transparent,
      onTap: (details) {
        if (details.appointments == null) return;
        final event = details.appointments!.first;

        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => EventViewingPage(event: event),
        ));
      },
    );
  }

  Widget appointmentBuilder(
    BuildContext context,
    CalendarAppointmentDetails details,
  ) {
    final event = details.appointments.first;

    return Container(
      width: details.bounds.width,
      height: details.bounds.height,
      decoration: BoxDecoration(
        color: event.backgroundColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          event.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
