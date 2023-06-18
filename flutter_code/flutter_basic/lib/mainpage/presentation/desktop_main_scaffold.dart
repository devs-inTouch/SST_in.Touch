import 'package:flutter/material.dart';
import 'package:flutter_basic/MoovitWidget.dart';
import 'package:flutter_basic/constants.dart';
import 'package:intl/intl.dart';
import '../../hojeNaFCT/avisos_info.dart';
import '../../hojeNaFCT/exposicoes_info.dart';
import '../../hojeNaFCT/noticias_info.dart';
import '../../hojeNaFCT/restauração_info.dart';
import '../../myAppBar.dart';
import '../../weatherBox.dart';
import 'auxMainpage.dart';

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
    return Scaffold(
      appBar: MyAppBar(),
      backgroundColor: Colors.grey[300],
      body: Padding(
        padding: EdgeInsets.all(50.0),
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
                              Icon(Icons
                                  .calendar_today_rounded), // Icon calendar
                              SizedBox(
                                  width:
                                      5), // Add some spacing between the icon and text
                              textTopBar('HOJE NA FCT'), // Text widget
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          pages[_currentPageIndex],
                          style: hojeNaFCTPageTitles,
                        ),
                      ),
                      if (pages[_currentPageIndex] == 'RESTAURAÇÃO')
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 20.0),
                            child: RestauracaoPage(),
                          ),
                        )
                      else if (pages[_currentPageIndex] == 'Avisos')
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 20.0),
                            child: AvisosPage(),
                          ),
                        )
                      else if (pages[_currentPageIndex] == 'Exposições')
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 20.0),
                            child: ExposicoesPage(),
                          ),
                        )
                      else if (pages[_currentPageIndex] == 'Notícias')
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 20.0),
                            child: NoticiasPage(),
                          ),
                        ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 20.0),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: goToPreviousPage,
                                icon: Icon(Icons.arrow_back),
                              ),
                              SizedBox(width: 30.0),
                              IconButton(
                                onPressed: goToNextPage,
                                icon: Icon(Icons.arrow_forward),
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
            Spacer(),
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
                          child: Stack(
                            children: [
                              Container(
                                width: double.infinity,
                                height: 250,
                                decoration: boxDecoration,
                                child: const MoovitWidget(),
                              ),
                              Positioned(
                                top: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  height: 50,
                                  decoration: topBarDecoration,
                                  child: Center(
                                    child: textTopBar('MOOVIT'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 50.0),
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
                                    child: Padding(
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
                  SizedBox(height: 25.0),
                  Expanded(
                    child: FractionallySizedBox(
                      widthFactor: 1,
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return Stack(
                            children: [
                              Container(
                                height: double
                                    .infinity, // Expand the container to fill the available height
                                decoration: boxDecoration,
                                child: Column(
                                  children: [
                                    Container(
                                      height: 50,
                                      decoration: topBarDecoration,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          textTopBar('AGENDA'),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                        padding: EdgeInsets.all(16.0),
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
                                  icon: Icon(Icons.add),
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
