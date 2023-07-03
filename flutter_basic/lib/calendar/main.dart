import 'package:flutter/material.dart';
import 'package:flutter_basic/calendar/page/event_editing_page.dart';
import 'package:flutter_basic/calendar/provider/event_provider.dart';
import 'package:provider/provider.dart';

import 'widget/calendar_widget.dart';
//import 'page/event_editing_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String title = "Calendar Events App";

  final MaterialColor primarySwatch = const MaterialColor(0xFF020279, {
    50: Color.fromRGBO(2, 2, 121, 0.1),
    100: Color.fromRGBO(2, 2, 121, 0.2),
    200: Color.fromRGBO(2, 2, 121, 0.3),
    300: Color.fromRGBO(2, 2, 121, 0.4),
    400: Color.fromRGBO(2, 2, 121, 0.5),
    500: Color.fromRGBO(2, 2, 121, 0.6),
    600: Color.fromRGBO(2, 2, 121, 0.7),
    700: Color.fromRGBO(2, 2, 121, 0.8),
    800: Color.fromRGBO(2, 2, 121, 0.9),
    900: Color.fromRGBO(2, 2, 121, 1.0),
  });

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => EventProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: title,
          theme: ThemeData(
            primarySwatch: primarySwatch,
            scaffoldBackgroundColor: Colors.white,
          ),
          home: const MainPage(),
          /* routes: {
            EventEditingPage.route: (context) => EventEditingPage(),
          }, */
        ),
      );
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  static const String title = "Calendar Events App";

  @override
  Widget build(BuildContext context) => Scaffold(
        body: const CalendarWidget(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 10, 2, 100),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) =>
                    EventEditingPage(fromDate: DateTime.now())),
          ),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      );
}
