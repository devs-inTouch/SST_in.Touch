
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basic/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../calendar/widget/calendar_schedule_widget.dart';
import '../../myAppBar.dart';
import '../../noticias/presentation/newsPage.dart';
import '../../weatherBox.dart';
import 'auxMainpage.dart';

class TabletScaffold extends StatefulWidget {
  const TabletScaffold({Key? key}) : super(key: key);

  @override
  State<TabletScaffold> createState() => _TabletScaffoldState();
}

class _TabletScaffoldState extends State<TabletScaffold> {

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fem = size.width / 1440; // 1440 is the reference width

    return Scaffold(
      appBar: const MyAppBar(),
      backgroundColor: myBackground,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: SizedBox(
                width: 500,
                child: Container(
                 child: NewsPage(),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Column(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Column(
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
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 10.0),
                                      child: Container(
                                        width: double.infinity,
                                        height: 110,
                                        decoration: boxDecoration,
                                        child: const WeatherBox(
                                          location: 'Costa Da Caparica',
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: GestureDetector(
                                onTap: () {
                                  launchUrl(Uri.parse('https://moovitapp.com/lisboa-2460/poi/pt'));
                                },
                                child: Image.asset(
                                  'assets/moovit.png',
                                  width: double.infinity,
                                  height: 150,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),


                          Expanded(
                                                    child: CalendarScheduleWidget(),

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
    );
  }
}




