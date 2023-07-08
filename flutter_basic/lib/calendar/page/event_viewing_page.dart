import 'package:flutter/material.dart';
import 'package:flutter_basic/calendar/provider/events_request.dart';

import '../model/event.dart';
import '../utils.dart';
import '../widget/calendar_widget.dart';
import 'calendar_page.dart';
import 'event_editing_page.dart';

class EventViewingPage extends StatefulWidget {
  final Event event;
  const EventViewingPage({
    Key? key,
    required this.event,
  }) : super(key: key);
  @override
  _EventViewingPageState createState() => _EventViewingPageState();
}

class _EventViewingPageState extends State<EventViewingPage> {
  final CalendarWidgetState calendarWidgetState = CalendarWidgetState();
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: CloseButton(),
          actions: buildViewingActions(context, widget.event),
        ),
        body: ListView(
          padding: EdgeInsets.all(32),
          children: <Widget>[
            buildDateTime(widget.event),
            SizedBox(height: 32),
            Text(
              widget.event.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Text(
              widget.event.description,
              style: TextStyle(color: Colors.black54, fontSize: 18),
            )
          ],
        ),
      );

  Widget buildDateTime(Event event) {
    return Column(
      children: [
        buildDate(event.isAllDay ? 'Todo o dia' : 'De', event.from),
        if (!event.isAllDay) buildDate('Para', event.to),
      ],
    );
  }

  Widget buildDate(String title, DateTime date) => Row(
        children: [
          Text(
            '$title: ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(Utils.toDate(date)),
        ],
      );
  List<Widget> buildViewingActions(BuildContext context, Event event) => [
        IconButton(
          icon: Icon(Icons.edit),
          onPressed: () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => EventEditingPage(
                event: event,
                fromDate: event.from,
              ),
            ),
          ),
        ),
        IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              EventRequests.deleteCalendarEvent(event.id).then((deleted) {
                if (deleted) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CalendarPage()),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Ups... Alguma coisa correu mal...'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Ok'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              });
            }),
      ];
}
