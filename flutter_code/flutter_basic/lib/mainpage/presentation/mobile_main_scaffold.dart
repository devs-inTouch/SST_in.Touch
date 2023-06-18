import 'package:flutter/material.dart';
import 'package:flutter_basic/constants.dart';
import 'package:intl/intl.dart';
import '../../hojeNaFCT/avisos_info.dart';
import '../../hojeNaFCT/exposicoes_info.dart';
import '../../hojeNaFCT/noticias_info.dart';
import '../../hojeNaFCT/restauração_info.dart';
import '../../myAppBar.dart';
import '../../weatherBox.dart';
import 'auxMainpage.dart';

class MobileScaffold extends StatefulWidget {
  const MobileScaffold({Key? key}) : super(key: key);

  @override
  State<MobileScaffold> createState() => _MobileScaffoldState();
}

class _MobileScaffoldState extends State<MobileScaffold> {
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
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: boxDecoration,
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
                          child: WeatherBox(location: 'Costa Da Caparica'),
                        ),
                      ),
                    ],
                  ),

                ),
                SizedBox(height: 30.0),
                Container(
                  width: double.infinity,
                  decoration: boxDecoration,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 50,
                        decoration: topBarDecoration,
                        child: Center(
                          child: textTopBar(
                              'MOOVIT'), // Use your custom textTopBar widget here
                        ),
                      ),
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
                    ],
                  ),
                ),
                SizedBox(height: 30.0),
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
                SizedBox(height: 10.0),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    pages[_currentPageIndex],
                    style: hojeNaFCTPageTitles,
                  ),
                ),
                if (pages[_currentPageIndex] == 'Restauração')
                  Container(
                    padding:
                    EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                    child: RestauracaoPage(),
                  )
                else
                  if (pages[_currentPageIndex] == 'Avisos')
                    Container(
                      padding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                      child: AvisosPage(),
                    )
                  else
                    if (pages[_currentPageIndex] == 'Exposições')
                      Container(
                        padding:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                        child: ExposicoesPage(),
                      )
                    else
                      if (pages[_currentPageIndex] == 'Notícias')
                        Container(
                          padding:
                          EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 20.0),
                          child: NoticiasPage(),
                        ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
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
                Container(
                  height: 50,
                  decoration: topBarDecoration,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      textTopBar('AGENDA'),
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
            ),
          ),
        ),
      ),
    );
  }
}