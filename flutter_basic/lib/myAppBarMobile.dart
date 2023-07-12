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
import 'package:flutter_basic/searchBarPage/presentation/responsive_searchPage.dart';
import 'package:flutter_basic/senhas/presentation/scan.dart';
import 'package:flutter_basic/senhas/presentation/senhas_page.dart';
import 'package:flutter_basic/teste/teste.dart';
import 'package:flutter_basic/maps/lib/map.dart';
import 'bottomAppBarMobile.dart';
import 'calendar/page/calendar_page.dart';
import 'constants.dart';
import 'mainpage/application/logoutAuth.dart';
import 'noticias/presentation/newsPage.dart';
import 'notifications/presentation/notificationList.dart';

class MyAppBarMobile extends StatefulWidget implements PreferredSizeWidget {
  const MyAppBarMobile({Key? key}) : super(key: key);

  @override
  _MyAppBarMobileState createState() => _MyAppBarMobileState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _MyAppBarMobileState extends State<MyAppBarMobile> {
  String? role;

  @override
  void initState() {
    super.initState();
    getRole().then((value) {
      setState(() {
        role = value;
      });
    });
  }

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
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Image.asset(
          'assets/logo-1-RBH.png',
          height: 35,
          fit: BoxFit.fitHeight,
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
                      backgroundColor: Colors.blue,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.grey[300],
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
