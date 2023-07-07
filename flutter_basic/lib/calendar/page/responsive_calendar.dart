import 'package:flutter/material.dart';

import 'calendar_page.dart';
import 'calendar_page_mobile.dart';


class ResponsiveCalendarLayout extends StatelessWidget {

  /**final Widget CalendarPageMobile;
  final Widget CalendarPage;

  const ResponsiveCalendarLayout({super.key,
    required this.CalendarPageMobile,
    required this.CalendarPage,
  }); **/

    @override
    Widget build(BuildContext context) {
      return LayoutBuilder(builder: (context, constraints) {
        if(constraints.maxWidth < 600){
          return CalendarPageMobile();
        }else {
          return CalendarPage();
        }
      },);
    }

  }
