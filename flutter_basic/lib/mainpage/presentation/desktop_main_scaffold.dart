import 'package:flutter/material.dart';
import 'package:flutter_basic/constants.dart';
import '../../calendar/widget/calendar_schedule_widget.dart';
import '../../hojeNaFCT/avisos_info.dart';
import '../../hojeNaFCT/exposicoes_info.dart';
import '../../hojeNaFCT/noticias_info.dart';
import '../../hojeNaFCT/restauração_info.dart';
import '../../myAppBar.dart';
import '../../weatherBox.dart';
import 'auxMainpage.dart';
import 'package:url_launcher/url_launcher.dart';

class DesktopScaffold extends StatefulWidget {
  const DesktopScaffold({Key? key}) : super(key: key);

  @override
  State<DesktopScaffold> createState() => _DesktopScaffoldState();
}

class _DesktopScaffoldState extends State<DesktopScaffold> {
  DateTime currentDate = DateTime.now();
  List<Map<String, dynamic>> events = [];
  int _currentPageIndex = 0; // Track the current page index
  List<String> pages = [
    'Restauração',
    'Avisos',
    'Exposições',
    'Notícias',
  ];

  AuxMainPage auxMainPage = AuxMainPage();
  void goToPreviousPage() {
    setState(() {
      _currentPageIndex =
          auxMainPage.goToPreviousPage(_currentPageIndex, pages);
    });
  }

  void goToNextPage() {
    setState(() {
      _currentPageIndex = auxMainPage.goToNextPage(_currentPageIndex, pages);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fem = size.width / 1440; // 1440 is the reference width

    return Scaffold(
      appBar: const MyAppBar(),
      backgroundColor: myBackground,
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: SizedBox(
                width: 500,
                child: Container(
                  decoration: boxDecoration,
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        decoration: topBarDecoration,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons
                                  .calendar_today_rounded), // Icon calendar
                              const SizedBox(
                                  width:
                                      5), // Add some spacing between the icon and text
                              textTopBar('HOJE NA FCT'), // Text widget
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          pages[_currentPageIndex],
                          style: hojeNaFCTPageTitles,
                        ),
                      ),
                      if (pages[_currentPageIndex] == 'Restauração')
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 20.0),
                            child: const RestauracaoPage(),
                          ),
                        )
                      else if (pages[_currentPageIndex] == 'Avisos')
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 20.0),
                            child: const AvisosPage(),
                          ),
                        )
                      else if (pages[_currentPageIndex] == 'Exposições')
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 20.0),
                            child: const ExposicoesPage(),
                          ),
                        )
                      else if (pages[_currentPageIndex] == 'Notícias')
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 20.0),
                            child: const NoticiasPage(),
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
            const Spacer(),
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: GestureDetector(
                            onTap: () {
                              launchUrl(Uri.parse(
                                  'https://moovitapp.com/lisboa-2460/poi/pt'));
                            },
                            child: Image.asset(
                              'assets/moovit.png',
                              width: double.infinity,
                              height: 250,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 50.0),
                        Flexible(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: 250,
                                    decoration: boxDecoration,
                                    child: const Padding(
                                      padding: EdgeInsets.only(top: 85),
                                      child: Center(
                                        child: WeatherBox(
                                            location: 'Costa Da Caparica'),
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
                                      child: Center(
                                        child: textTopBar('TEMPO NO CAMPUS'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25.0),
                  const CalendarScheduleWidget()
                  /*  Expanded(
                    child: FractionallySizedBox(
                      widthFactor: 1,
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return Stack(
                            children: [
                              Container(
                                height: double.infinity,
                                decoration: boxDecoration,
                                child: Column(
                                  children: [
                                    Container(
                                      height: 50,
                                      decoration: topBarDecoration,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [],
                                      ),
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                        padding: const EdgeInsets.all(16.0),
                                        itemCount: events.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          Map<String, dynamic> event =
                                              events[index];
                                          return EventCard(event: event);
                                        },
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
                                    auxMainPage.addNewActivity(context, events);
                                  },
                                  icon: const Icon(Icons.add),
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ), */
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
