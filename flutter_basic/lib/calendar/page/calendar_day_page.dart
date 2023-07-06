import 'package:flutter/material.dart';
import 'package:flutter_basic/myAppBar.dart';
import 'package:provider/provider.dart';

import '../provider/event_provider.dart';
import '../widget/calendar_day_widget.dart';
import 'event_editing_page.dart';

class CalendarDayPage extends StatefulWidget {
  @override
  _CalendarDayPageState createState() => _CalendarDayPageState();
}

class _CalendarDayPageState extends State<CalendarDayPage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EventProvider>(context);
    final selectedDate = provider.selectedDate;
    return Scaffold(
      appBar: MyAppBar(),
      body: CalendarDayWidget(
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
