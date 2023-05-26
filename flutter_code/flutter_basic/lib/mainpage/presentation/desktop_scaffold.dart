import 'package:flutter/material.dart';
import 'package:flutter_basic/constants.dart';
import 'package:intl/intl.dart';

import '../hojeNaFCT/avisos_info.dart';
import '../hojeNaFCT/exposicoes_info.dart';
import '../hojeNaFCT/noticias_info.dart';
import '../hojeNaFct.dart';
import '../myAppBar.dart';
import '../hojeNaFCT/restauração_info.dart';
import '../weatherBox.dart';

class DesktopScaffold extends StatefulWidget {
  const DesktopScaffold({Key? key}) : super(key: key);

  @override
  State<DesktopScaffold> createState() => _DesktopScaffoldState();
}

class _DesktopScaffoldState extends State<DesktopScaffold> {
  DateTime currentDate = DateTime.now();
  List<Map<String, dynamic>> events = [];
  int _currentPageIndex = 0; // Track the current page index
  int _currentDayIndex = 0; // Track the current day index
  List<String> pages = [
    'Restauração',
    'Avisos',
    'Exposições',
    'Notícias',
  ];

  void goToNextDay() {
    setState(() {
      if (_currentDayIndex == days.length - 1) {
        _currentDayIndex = 0;
      } else {
        _currentDayIndex++;
      }
    });
  }

  void goToPreviousDay() {
    setState(() {
      if (_currentDayIndex == days.length - 1) {
        _currentDayIndex = 0;
      } else {
        _currentDayIndex++;
      }
    });
  }

  void goToPreviousPage() {
    setState(() {
      if (_currentPageIndex == 0) {
        _currentPageIndex = pages.length - 1;
      } else {
        _currentPageIndex--;
      }
    });
  }

  List<String> days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  void goToNextPage() {
    setState(() {
      if (_currentPageIndex == pages.length - 1) {
        _currentPageIndex = 0;
      } else {
        _currentPageIndex++;
      }
    });
  }

  // Define a list to store the events
  // List<String> events = [];

  // Define variables to store the selected day and event name
  String selectedDay = '';
  String eventName = '';

  // Function to handle adding new events
  /** void addEvent() {
      if (selectedDay.isNotEmpty && eventName.isNotEmpty) {
      setState(() {
      events.add('$selectedDay: $eventName');
      selectedDay = '';
      eventName = '';
      });
      }
      }
   **/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Expanded(
          flex: 1,
          child: Container(
            width: 500,
            decoration: boxDecoration,
            child: Column(
              children: [
                Container(
                  height: 50,
                  decoration: topBarDecoration,
                  child: Center(
                    child: textTopBar('Hoje Na FCT'),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    pages[_currentPageIndex],
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
                if (pages[_currentPageIndex] == 'Restauração')
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                      child: RestauracaoPage(),
                    ),
                  )
                 else if (pages[_currentPageIndex] == 'Avisos')
                   Expanded(
                     child: Container(
                       padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                       child: AvisosPage(),
                     ),
                   )
                 else if (pages[_currentPageIndex] == 'Exposições')
                   Expanded(
                     child: Container(
                       padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                       child: ExposicoesPage(),
                     ),
                   )
                 else if (pages[_currentPageIndex] == 'Notícias')
                   Expanded(
                     child: Container(
                       padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                       child: NoticiasPage(),
                     ),
                   ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: goToPreviousPage,
                          icon: const Icon(Icons.arrow_back),
                        ),
                        const SizedBox(width: 30.0),
                        IconButton(
                          onPressed: goToNextPage,
                          icon: const Icon(Icons.arrow_forward),
                        ),
                      ),
                      if (pages[_currentPageIndex] == 'RESTAURAÇÃO')
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 20.0),
                            child: RestauracaoPage(),
                          ),
                        )
                      else if (pages[_currentPageIndex] == 'Avisos')
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 20.0),
                            child: AvisosPage(),
                          ),
                        )
                      else if (pages[_currentPageIndex] == 'Exposições')
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 20.0),
                            child: ExposicoesPage(),
                          ),
                        )
                      else if (pages[_currentPageIndex] == 'Notícias')
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 20.0),
                            child: NoticiasPage(),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: goToPreviousPage,
                                icon: const Icon(Icons.arrow_back),
                              ),
                              const SizedBox(width: 30.0),
                              IconButton(
                                onPressed: goToNextPage,
                                icon: const Icon(Icons.arrow_forward),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),



          const Spacer(),
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: 250,
                            height: 250,
                            decoration: boxDecoration,
                            child: Center(
                              child: Text(
                                "Box 1",
                                style: textStyle,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: 50,
                              decoration: topBarDecoration,
                              // Apply the topBarDecoration here
                              child: Center(
                                child: textTopBar(
                                    'MOOVIT'), // Use your custom textTopBar widget here
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 150.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Container(
                                width: 250,
                                height: 250,
                                decoration: boxDecoration,
                                child: const Center(
                                  child: Text(
                                    "Box 2",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ),

                              Positioned(
                                top: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  height: 50,
                                  decoration: topBarDecoration,
                                  // Apply the topBarDecoration here
                                  child: Center(
                                    child: textTopBar(
                                        'Tempo no Campus'), // Use your custom textTopBar widget here
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 25.0), // Adjust the spacing between the row of boxes and the "Agenda" box
                  Align(
                    alignment: Alignment.bottomRight,
                    child: FractionallySizedBox(
                      widthFactor: 1.1,
                      child: Stack(
                        children: [
                          Container(
                            height: 350,
                            decoration: boxDecoration,
                            child: Column(
                              children: [
                                Container(
                                  height: 50,
                                  decoration: topBarDecoration,
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Agenda",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Scrollbar(
                                    child: ListView.builder(
                                      itemCount: events.length,
                                      itemBuilder: (context, index) {
                                        return EventCard(event: events[index]);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: IconButton(
                              onPressed: () {
                                // Add your functionality for adding new activities here
                                addNewActivity(context);
                              },
                              icon: const Icon(Icons.add),
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    )
  }

  void addNewActivity(BuildContext context) async {
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
            title: const Text('Adicionar evento'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                  ),
                  onChanged: (value) {
                    eventName = value;
                  },
                ),
                const SizedBox(height: 16.0),
                Text(
                  'Data selecionada: ${DateFormat('MMMM dd, yyyy').format(selectedDate)}',
                  style: const TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 8.0),

                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
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
                    });
                  },
                  child: const Text('Adicionar'),
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

  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: boxEventDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Data: ${DateFormat('MMMM dd, yyyy').format(event['Data'])}',
            style: textStyleEvents,
          ),
          const SizedBox(height: 8.0),
          Text(
            'Evento: ${event['Evento']}',
            style: textStyleEvents,
          ),
          const SizedBox(height: 8.0),
          Text(
            'Dias Restantes: ${event['DiasRestantesTexto']}',
            style: textStyleEvents,
          ),
        ],
      ),
    );
  }
}
