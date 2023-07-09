

import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basic/constants.dart';
import 'package:flutter_basic/noticias/presentation/newsPageMobile.dart';
import '../../bottomAppBarMobile.dart';
import '../../calendar/widget/calendar_schedule_widget.dart';

import '../../myAppBar.dart';
import '../../myAppBarMobile.dart';
import '../../noticias/presentation/newsPage.dart';
import '../../weatherBox.dart';
import 'auxMainpage.dart';

class MobileScaffold extends StatefulWidget {
  const MobileScaffold({Key? key}) : super(key: key);

  @override
  State<MobileScaffold> createState() => _MobileScaffoldState();
}

class _MobileScaffoldState extends State<MobileScaffold> {

  AuxMainPage auxMainPage = AuxMainPage();



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
                        decoration: mainMenuDecoration,
                        child: Center(
                          child: Text(
                            'TEMPO NO CAMPUS',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
                          height: 500,
                          decoration: boxDecoration,
                          child:
                          const NewsPageMobile(),
                        ),

                /**
                    Container(
                    child: NewsPage(),
                    ),
                 **/
                const SizedBox(height: 30.0),

                const CalendarScheduleWidget(),
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



              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: MyBottomAppBar(),


    );
  }
}


