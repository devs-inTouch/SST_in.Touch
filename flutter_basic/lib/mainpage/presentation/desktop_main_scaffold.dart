import 'package:flutter/material.dart';
import 'package:flutter_basic/constants.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../calendar/widget/calendar_schedule_widget.dart';

import '../../myAppBar.dart';
import '../../noticias/presentation/newsPage.dart';
import '../../weatherBox.dart';
import 'auxMainpage.dart';

class DesktopScaffold extends StatefulWidget {
  const DesktopScaffold({Key? key}) : super(key: key);

  @override
  State<DesktopScaffold> createState() => _DesktopScaffoldState();
}

class _DesktopScaffoldState extends State<DesktopScaffold> {


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
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: SizedBox(
                  width: 500,
                  child: Container(
                    child: NewsPage(),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: SizedBox(
                  width: 500,
                  child: Container(
                    child: CalendarScheduleWidget(),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Column(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Stack(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: 250,
                                    decoration: boxDecoration,
                                    child: const Padding(
                                      padding: EdgeInsets.only(top: 85),
                                      child: Center(
                                        child: WeatherBox(
                                          location: 'Costa Da Caparica',
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    left: 0,
                                    right: 0,
                                    child: Container(
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
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 50.0),
                            Expanded(
                              flex: 1,
                              child: GestureDetector(
                                onTap: () {
                                  launchUrl(Uri.parse(
                                      'https://moovitapp.com/lisboa-2460/poi/pt'));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
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
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
