import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../constants.dart';
import '../../eventCalendar.dart';
import '../../myAppBar.dart';

class TabletProfileScaffold extends StatefulWidget {
  final String name;
  final String imageAssetPath;
  final String role;
  final String year;
  final String nucleos;

  const TabletProfileScaffold({super.key, 
    required this.name,
    required this.imageAssetPath,
    required this.role,
    required this.year,
    required this.nucleos,
  });

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<TabletProfileScaffold> {
  bool _isEditing = false;
  List<Event> events = [];
  DateTime today=DateTime.now();
  Map<DateTime, List<Event>> eventsByDay = {};

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  void _showAddEventDialog() {
    String title = '';
    DateTime date = DateTime.now();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Event'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (text) {
                  title = text;
                },
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: () async {
                  final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: date,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null && pickedDate != date) {
                    setState(() {
                      date = pickedDate;
                    });
                  }
                },
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today),
                    const SizedBox(width: 8),
                    Text(
                      DateFormat('dd/MM/yyyy').format(date),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Event event = Event(title: title, date: date, day: date);

                setState(() {
                  events.add(event);

                  // Add the event to the eventsByDay map
                  if (!eventsByDay.containsKey(date)) {
                    eventsByDay[date] = [];
                  }
                  eventsByDay[date]!.add(event);
                });

                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
  Widget topBarProfile({required String text}) {
    return Container(
      decoration: topBarDecoration,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            IconButton(
              icon: Icon(_isEditing ? Icons.done : Icons.edit),
              onPressed: () {
                setState(() {
                  _isEditing = !_isEditing;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
  Widget topBarCalendar({required String text, VoidCallback? onSave}) {
    return Container(
      decoration: topBarDecoration,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    _showAddEventDialog();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fem = size.width / 1440;  // 1440 is the reference width

    return Scaffold(
      appBar: const MyAppBar(),
      drawer: myDrawer,
      backgroundColor: myBackground,
      body: Stack(
        children: [
          SizedBox(
            width: size.width,
            height: size.height,
            child: Stack(
              children: [
                Positioned(
                  left: 1030 * fem,
                  top: 50 * fem,
                  child: SizedBox(
                    width: 150 * (fem*1.5),
                    height: 150 * (fem*1.5),
                    child: Container(
                      decoration: boxDecoration,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'foto de perfil :)',
                            style: TextStyle(
                              fontSize: 15 * fem,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                //info do perfil
                Positioned(
                  // info
                  left: size.width * 0.05,
                  top: size.height * 0.05,
                  child: Container(
                    width: size.width * 0.5,
                    height: size.height * 0.8,
                    decoration: boxDecoration,
                    child: Column(
                      children: [
                        topBarProfile(text: "Profile"),
                        SizedBox(height: 16 * fem),
                        Expanded(
                          child: ListView(
                            padding: EdgeInsets.symmetric(horizontal: 24 * fem),
                            children: [
                              ListTile(
                                title: const Text(
                                  "Name:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                trailing: SizedBox(
                                  width: size.width * 0.25,
                                  child: TextField(
                                    decoration: const InputDecoration(
                                      hintText: "Name space",
                                    ),
                                    enabled: _isEditing,
                                  ),
                                ),
                              ),
                              ListTile(
                                title: const Text(
                                  "Email:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                trailing: SizedBox(
                                  width: size.width * 0.25,
                                  child: TextField(
                                    decoration: const InputDecoration(
                                      hintText: "Email space",
                                    ),
                                    enabled: _isEditing,
                                  ),
                                ),
                              ),
                              ListTile(
                                title: const Text(
                                  "Role:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                trailing: SizedBox(
                                  width: size.width * 0.25,
                                  child: TextField(
                                    decoration: const InputDecoration(
                                      hintText: "Role space",
                                    ),
                                    enabled: _isEditing,
                                  ),
                                ),
                              ),
                              ListTile(
                                title: const Text(
                                  "State:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                trailing: SizedBox(
                                  width: size.width * 0.25,
                                  child: TextField(
                                    decoration: const InputDecoration(
                                      hintText: "State space",
                                    ),
                                    enabled: _isEditing,
                                  ),
                                ),
                              ),
                              ListTile(
                                title: const Text(
                                  "Department:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                trailing: SizedBox(
                                  width: size.width * 0.25,
                                  child: TextField(
                                    decoration: const InputDecoration(
                                      hintText: "Department space",
                                    ),
                                    enabled: _isEditing,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16 * fem),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    String oldPassword = "";
                                    String newPassword = "";
                                    String confirmPassword = "";

                                    return AlertDialog(
                                      title: const Text("Change Password"),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextField(
                                            onChanged: (text) {
                                              oldPassword = text;
                                            },
                                            decoration: const InputDecoration(
                                              labelText: "Old Password",
                                            ),
                                          ),
                                          TextField(
                                            onChanged: (text) {
                                              newPassword = text;
                                            },
                                            decoration: const InputDecoration(
                                              labelText: "New Password",
                                            ),
                                          ),
                                          TextField(
                                            onChanged: (text) {
                                              confirmPassword = text;
                                            },
                                            decoration: const InputDecoration(
                                              labelText: "Confirm Password",
                                            ),
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
// Handle "Confirm" button press
                                            if (newPassword ==
                                                confirmPassword) {
// TODO: update password and close dialog
                                              Navigator.of(context).pop();
                                            } else {
// TODO: display error message
                                            }
                                          },
                                          child: const Text("Confirm"),
                                        ),
                                        TextButton(
                                          onPressed: () {
// Handle "Cancel" button press
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text("Cancel"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: const Text(
                                "Change Password",
                                style: TextStyle(
                                  color: Color(0xff1276eb),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                //calendario
                Positioned(
                  // rectangle6JN6 (42:4)
                  left: size.width * 0.62,
                  top: size.height * 0.3,
                  child: Container(
                    width: size.width * 0.35,
                    height: size.height * 0.55,
                    decoration: boxDecoration,
                    child:Column(
                      children: [
                        topBarCalendar(text: "Calendar"),

                        Container(
                          child: TableCalendar(
                            locale: "en_US",
                            headerStyle: const HeaderStyle(
                                formatButtonVisible: false,
                                titleCentered: true),
                            availableGestures: AvailableGestures.all,
                            selectedDayPredicate: (day) =>
                                isSameDay(day, today),
                            focusedDay: today,
                            firstDay: DateTime.utc(2010, 10, 16),
                            lastDay: DateTime.utc(2030, 10, 16),
                            onDaySelected: _onDaySelected,
                            eventLoader: (day) => eventsByDay[day] ?? [],
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: events.length,
                            itemBuilder: (BuildContext context, int index) {
                              if (events[index].date == today) {
                                return ListTile(
                                  title: Text(events[index].title),
                                  subtitle: Text(DateFormat('dd/MM/yyyy')
                                      .format(events[index].date)),
                                );
                              } else {
                                return const ListTile(
                                  title: Text('n'),
                                );
                              }
                            },
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
    );
  }

}
