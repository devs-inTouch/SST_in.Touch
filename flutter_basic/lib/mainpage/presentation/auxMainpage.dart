import 'package:flutter/material.dart';
import 'package:flutter_basic/constants.dart';
import 'package:intl/intl.dart';

import '../../myAppBar.dart';
import '../../weatherBox.dart';

class AuxMainPage {
  int goToPreviousPage(int currentPageIndex, List<String> pages) {
    int newPageIndex = currentPageIndex;
    if (newPageIndex == 0) {
      newPageIndex = pages.length - 1;
    } else {
      newPageIndex--;
    }
    return newPageIndex;
  }

  int goToNextPage(int currentPageIndex, List<String> pages) {
    int newPageIndex = currentPageIndex;
    if (newPageIndex == pages.length - 1) {
      newPageIndex = 0;
    } else {
      newPageIndex++;
    }
    return newPageIndex;
  }

  void addNewActivity(BuildContext context, List<Map<String, dynamic>> events) async {
    String eventName = '';
    DateTime selectedDate = DateTime.now();

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 10),
    );

    if (pickedDate != null) {
      selectedDate = pickedDate;

      int daysRemaining = DateTime.utc(
            pickedDate.year, pickedDate.month, pickedDate.day)
          .difference(DateTime.utc(
            DateTime.now().year, DateTime.now().month, DateTime.now().day))
          .inDays;

      String daysRemainingText;
      if (daysRemaining == 0) {
        daysRemainingText = 'Hoje';
      } else if (daysRemaining == 1) {
        daysRemainingText = 'Amanhã';
      } else {
        daysRemainingText = daysRemaining.toString();
      }

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Adicionar evento'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Nome',
                  ),
                  onChanged: (value) {
                    eventName = value;
                  },
                ),
                SizedBox(height: 16.0),
                Text(
                  'Data selecionada: ${DateFormat('MMMM dd, yyyy').format(selectedDate)}',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 8.0),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    // Create the event and add it to the agenda
                    Map<String, dynamic> event = {
                      'Data': selectedDate,
                      'Evento': eventName,
                      'DiasRestantes': daysRemaining,
                      'DiasRestantesTexto': daysRemainingText,
                    };

                    events.add(event);

                    // Sort events by ascending order of days remaining
                    events.sort((a, b) =>
                        a['DiasRestantes'].compareTo(b['DiasRestantes']));

                    Navigator.pop(context);
                  },
                  child: Text('Adicionar'),
                ),
              ],
            ),
          );
        },
      );
    }
  }
}

class EventCard extends StatelessWidget {
  final Map<String, dynamic> event;

  const EventCard({required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      padding: EdgeInsets.all(16.0),
      decoration: boxEventDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Data: ${DateFormat('MMMM dd, yyyy').format(event['Data'])}',
            style: textStyleEvents,
          ),
          SizedBox(height: 8.0),
          Text(
            'Evento: ${event['Evento']}',
            style: textStyleEvents,
          ),
          SizedBox(height: 8.0),
          Text(
            'Dias Restantes: ${event['DiasRestantesTexto']}',
            style: textStyleEvents,
          ),
        ],
      ),
    );
  }
}
