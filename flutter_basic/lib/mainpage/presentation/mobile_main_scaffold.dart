

import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basic/constants.dart';
import '../../bottomAppBarMobile.dart';
import '../../hojeNaFCT/avisos_info.dart';
import '../../hojeNaFCT/exposicoes_info.dart';
import '../../hojeNaFCT/noticias_info.dart';
import '../../hojeNaFCT/restauração_info.dart';
import '../../myAppBar.dart';
import '../../myAppBarMobile.dart';
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
      appBar: const MyAppBarMobile(),
      backgroundColor: myBackground,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
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
                          child:
                          const WeatherBox(location: 'Costa Da Caparica'),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30.0),
                Container(
                  width: double.infinity,
                  decoration: boxDecoration,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () async {
                          await LaunchApp.openApp(
                            androidPackageName: 'com.tranzmate',
                            openStore: true,
                          );
                        },
                        child: Image.asset(
                          'assets/moovit.png',
                          width: double.infinity,
                          height: 250,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30.0),

                Container(
                  height: 50,
                  decoration: topBarDecoration,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.calendar_today_rounded),
                        // Icon calendar
                        const SizedBox(width: 5),
                        // Add some spacing between the icon and text
                        textTopBar('HOJE NA FCT'),
                        // Text widget
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),

                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    pages[_currentPageIndex],
                    style: hojeNaFCTPageTitles,
                  ),
                ),
                if (pages[_currentPageIndex] == 'RESTAURAÇÃO')
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

                Column(
                  children: [
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
                Align(
                  alignment: Alignment.bottomRight,
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
            ),
          ),
        ),
      ),
      bottomNavigationBar: MyBottomAppBar(),


    );
  }
}


