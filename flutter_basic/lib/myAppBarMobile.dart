import 'package:flutter/material.dart';
import 'package:flutter_basic/anomalies/presentation/anomaliesPage.dart';
import 'package:flutter_basic/backoffice/presentation/backOfficePage.dart';
import 'package:flutter_basic/feeds/presentation/feedPage.dart';
import 'package:flutter_basic/login/presentation/loginPage.dart';
import 'package:flutter_basic/mainpage/presentation/desktop_main_scaffold.dart';
import 'package:flutter_basic/mainpage/presentation/mobile_main_scaffold.dart';
import 'package:flutter_basic/mainpage/presentation/responsive_main_page.dart';
import 'package:flutter_basic/mainpage/presentation/tablet_main_scaffold.dart';
import 'package:flutter_basic/nucleos/presentation/nucleosPage.dart';
import 'package:flutter_basic/profile/presentation/profile_scaffold.dart';
import 'package:flutter_basic/reports/presentation/reportsPage.dart';
import 'package:flutter_basic/reservaSalas/presentation/responsive_reservasalas.dart';
import 'package:flutter_basic/teste/teste.dart';
import 'package:flutter_basic/maps/lib/map.dart';
import 'bottomAppBarMobile.dart';
import 'calendar/page/calendar_page.dart';
import 'mainpage/application/logoutAuth.dart';
import 'messages/application/chatScreen.dart';
import 'noticias/presentation/newsPage.dart';
import 'notifications/presentation/notificationList.dart';

class MyAppBarMobile extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBarMobile({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  void logoutButtonPressed(BuildContext context) {
    LogoutAuth.logout().then((isLoggedout) {
      if (isLoggedout) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MyApp()),
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Ups... Alguma coisa correu mal...'),
              actions: <Widget>[
                TextButton(
                  child: const Text('Ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Image.asset(
                'assets/logo-1-RBH.png',
                height: 35, // Define the desired height for the image
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(width: 10.0),
            IconButton(
              icon: Icon(Icons.search, color: Colors.black),
              onPressed: () {
                // Implement your search logic here
              },
            ),
          ],
        ),
        actions: [
          PopupMenuButton<Notification>(
            icon: const Icon(Icons.notifications, color: Colors.black),
            color: Colors.white,
            offset: const Offset(0, kToolbarHeight),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<Notification>(
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      backgroundColor:
                          Colors.blue, // Set the background color to blue
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.grey[300], // Light grey for tiles
                      ),
                      child: const SizedBox(
                        height: 500,
                        width: 700,
                        child: NotificationPage(),
                      ),
                    ),
                  ),
                ),
              ];
            },
          ),
        ],
      ),
    );
  }
}
