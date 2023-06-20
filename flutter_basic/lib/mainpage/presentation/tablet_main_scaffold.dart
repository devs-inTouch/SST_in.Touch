import 'package:flutter/material.dart';
import 'package:flutter_basic/constants.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';


import '../../hojeNaFCT/avisos_info.dart';
import '../../hojeNaFCT/exposicoes_info.dart';
import '../../hojeNaFCT/noticias_info.dart';
import '../../hojeNaFCT/restauração_info.dart';
import '../../myAppBar.dart';
import '../../weatherBox.dart';
import 'auxMainpage.dart';

class TabletScaffold extends StatefulWidget {
  const TabletScaffold({Key? key}) : super(key: key);

  @override
  State<TabletScaffold> createState() => _TabletScaffoldState();
}

class _TabletScaffoldState extends State<TabletScaffold> {
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
        padding: EdgeInsets.all(20.0),
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
                              Icon(Icons.calendar_today_rounded),
                              // Icon calendar
                              SizedBox(width: 5),
                              // Add some spacing between the icon and text
                              textTopBar('HOJE NA FCT'),
                              // Text widget
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
                      else
                        if (pages[_currentPageIndex] == 'Avisos')
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 20.0),
                              child: AvisosPage(),
                            ),
                          )
                        else
                          if (pages[_currentPageIndex] == 'Exposições')
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 20.0, horizontal: 20.0),
                                child: ExposicoesPage(),
                              ),
                            )
                          else
                            if (pages[_currentPageIndex] == 'Notícias')
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 50,
                                decoration: topBarDecoration,
                                child: Center(
                                  child: textTopBar('Tempo no Campus'),
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  width: double.infinity,
                                  height: 100,
                                  decoration: boxDecoration,
                                  child: WeatherBox(
                                      location: 'Costa Da Caparica'),
                                ),
                              ),
                            ],
                          ),

                        ),
                      ],
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: 1,
                    child: Stack(
                      children: [
                        Expanded(
                          child: Center(
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
                          //double containerHeight = constraints.maxHeight - 50; // Subtract the height of the top bar
                          return Stack(
                            children: [
                              Container(
                                height: double.infinity,
                                // Expand the container to fill the available height
                                decoration: boxDecoration,
                                child: Column(
                                  children: [
                                    Container(
                                      height: 50,
                                      decoration: topBarDecoration,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        children: [
                                          textTopBar('AGENDA'),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 350,
                                        child: Scrollbar(
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: events.map((event) {
                                                return EventCard(event: event);
                                              }).toList(),
                                            ),
                                          ),
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
                                    auxMainPage.addNewActivity(context, events);                                  },

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