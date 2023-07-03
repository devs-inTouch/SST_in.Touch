import 'package:flutter/material.dart';

import '../model/event.dart';

class EventProvider extends ChangeNotifier {
  final List<Event> _events = [];

  List<Event> get events => _events;

  DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => _selectedDate;

  void setDate(DateTime date) {
    _selectedDate = date;

    notifyListeners();
  }

  List<Event> get eventsOfSelectedDate => _events.where((event) {
        final eventDate = event.from;

        return eventDate.year == _selectedDate.year &&
            eventDate.month == _selectedDate.month &&
            eventDate.day == _selectedDate.day;
      }).toList();

  void addEvent(Event event) {
    _events.add(event);

    notifyListeners();
  }

  void editEvent(Event newEvent, Event oldEvent) {
    final index = _events.indexOf(oldEvent);

    _events[index] = newEvent;

    notifyListeners();
  }

  void deleteEvent(Event event) {
    _events.remove(event);

    notifyListeners();
  }
}
