import 'package:flutter/material.dart';

import '../model/event.dart';
import 'events_request.dart';

class EventProvider extends ChangeNotifier {
  List<Event> _events = [];

  List<Event> get getEvents => _events;

  DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => _selectedDate;

  void setDate(DateTime date) {
    _selectedDate = date;

    notifyListeners();
  }

  Future<void> initializeEvents() async {
    _events = await EventRequests.getCalendarEvents();
    notifyListeners();
  }

  List<Event> get eventsOfSelectedDate => _events.where((event) {
        final eventDate = event.from;

        return eventDate.year == _selectedDate.year &&
            eventDate.month == _selectedDate.month &&
            eventDate.day == _selectedDate.day;
      }).toList();

  List<Event> get publicEvents =>
      _events.where((event) => event.isPublic).toList();

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
