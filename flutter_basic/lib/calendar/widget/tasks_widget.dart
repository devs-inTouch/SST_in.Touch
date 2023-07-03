// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import '../model/event_data_source.dart';
import '../page/event_viewing_page.dart';
import '../provider/event_provider.dart';

class TasksWidget extends StatefulWidget {
  const TasksWidget({Key? key}) : super(key: key);

  @override
  _TasksWidgetState createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EventProvider>(context);
    final selectedDate = provider.selectedDate;
    print(selectedDate);
    final selectedEvents = provider.eventsOfSelectedDate;

    if (selectedEvents.isEmpty) {
      return const Center(
        child: Text(
          'No Events',
          style: TextStyle(color: Colors.red, fontSize: 24),
        ),
      );
    }
    print(provider.selectedDate);

    return SfCalendarTheme(
      data: SfCalendarThemeData(
        timeTextStyle: const TextStyle(
          fontSize: 18,
          color: Colors.white,
        ),
      ),
      child: SfCalendar(
        view: CalendarView.day,
        dataSource: EventDataSource(provider.events),
        initialDisplayDate: selectedDate,
        appointmentBuilder: appointmentBuilder,
        headerHeight: 0,
        todayHighlightColor: Colors.black,
        selectionDecoration: const BoxDecoration(
          color: Colors.transparent,
          // border: Border.all(color: Colors.white, width: 2),
          // borderRadius: BorderRadius.circular(12),
        ),
        onTap: (details) {
          if (details.appointments == null) return;
          final event = details.appointments!.first;

          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => EventViewingPage(event: event),
          ));
        },
      ),
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
