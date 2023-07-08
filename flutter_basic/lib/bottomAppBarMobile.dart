import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basic/anomalies/presentation/responsive_anomaliesPage.dart';
import 'package:flutter_basic/calendar/page/responsive_calendar.dart';
import 'package:flutter_basic/feeds/presentation/responsiveFeed.dart';
import 'package:flutter_basic/maps/lib/responsiveMap.dart';
import 'package:flutter_basic/nucleos/presentation/responsive_nucleos_page.dart';
import 'package:flutter_basic/profile/presentation/profile_scaffold.dart';
import 'package:flutter_basic/reports/presentation/reportsPage.dart';
import 'package:flutter_basic/reports/presentation/responsive_reportsPage.dart';
import 'package:flutter_basic/reservaSalas/presentation/responsive_reservasalas.dart';

import 'anomalies/presentation/anomaliesPage.dart';
import 'backoffice/presentation/backOfficePage.dart';
import 'backoffice/presentation/responsive_backOffice.dart';
import 'calendar/page/calendar_page.dart';
import 'feeds/presentation/feedPage.dart';
import 'login/presentation/loginPage.dart';
import 'mainpage/application/logoutAuth.dart';
import 'mainpage/presentation/desktop_main_scaffold.dart';
import 'mainpage/presentation/mobile_main_scaffold.dart';
import 'mainpage/presentation/responsive_main_page.dart';
import 'mainpage/presentation/tablet_main_scaffold.dart';
import 'maps/lib/map.dart';
import 'messages/application/chatScreen.dart';
import 'noticias/presentation/newsPage.dart';
import 'noticias/presentation/responsiveNewsPage.dart';
import 'nucleos/presentation/nucleosPage.dart';

class MyBottomAppBar extends StatelessWidget {
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

  Widget build(BuildContext context) {
    return Container(
      height: 40, // Altura desejada da BottomAppBar
      child: BottomAppBar(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
          PopupMenuButton(
            icon: const Icon(Icons.list, color: Colors.black),
            color: Colors.white,
            offset: const Offset(0, kToolbarHeight),
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                child: Container(
                  color: Colors.white,
                  // Set the background color of the menu item to white
                  child: ListTile(
                    leading: const Icon(Icons.feed),
                    title: const Text('Feed'),
                    onTap: () {
                      // Handle logout button click
                      Navigator.pop(context); // Close the menu
                      // Implement your logic here
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ResponsiveFeedPage()),
                      );
                    },
                  ),
                ),
              ),
              PopupMenuItem(
                child: Container(
                  color: Colors.white,
                  // Set the background color of the menu item to white
                  child: ListTile(
                    leading: const Icon(Icons.map),
                    title: const Text('Maps'),
                    onTap: () {
                      // Handle logout button click
                      Navigator.pop(context); // Close the menu
                      // Implement your logic here
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  ResponsiveMap()),
                      );
                    },
                  ),
                ),
              ),
              PopupMenuItem(
                child: Container(
                  color: Colors.white,
                  // Set the background color of the menu item to white
                  child: ListTile(
                    leading: const Icon(Icons.terminal),
                    title: const Text('Tests'),
                    onTap: () {
                      // Handle logout button click
                      Navigator.pop(context); // Close the menu
                      // Implement your logic here
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ResponsiveCalendarLayout()),
                      );
                    },
                  ),
                ),
              ),
              PopupMenuItem(
                child: Container(
                  color: Colors.white,
                  // Set the background color of the menu item to white
                  child: ListTile(
                    leading: const Icon(Icons.newspaper),
                    title: const Text('Notícias'),
                    onTap: () {
                      // Handle logout button click
                      Navigator.pop(context); // Close the menu
                      // Implement your logic here
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ResponsiveNewsPage()),
                      );
                    },
                  ),
                ),
              ),
              PopupMenuItem(
                child: Container(
                  color: Colors.white,
                  // Set the background color of the menu item to white
                  child: ListTile(
                    leading: const Icon(Icons.groups),
                    title: const Text('Núcleos'),
                    onTap: () {
                      // Handle logout button click
                      Navigator.pop(context); // Close the menu
                      // Implement your logic here
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ResponsiveNucleosPage()),
                      );
                    },
                  ),
                ),
              ),
              PopupMenuItem(
                child: Container(
                  color: Colors.white,
                  // Set the background color of the menu item to white
                  child: ListTile(
                    leading: const Icon(Icons.chat),
                    title: const Text('Chat'),
                    onTap: () {
                      // Handle logout button click
                      Navigator.pop(context); // Close the menu
                      // Implement your logic here
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatScreen(
                            conversation: null,
                            onConversationSelected: (Conversation) {},
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ResponsiveLayout(
                          mobileScaffold: MobileScaffold(),
                          tabletScaffold: TabletScaffold(),
                          desktopScaffold: DesktopScaffold(),
                        ),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Icon(Icons.home),
                      Text('Página inicial', style: TextStyle(fontSize: 10)),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  ResponsiveMap()),
                    );
                  },
                  child: Column(
                    children: [
                      Icon(Icons.map),
                      Text('Mapa', style: TextStyle(fontSize: 10)),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ResponsiveCalendarLayout()),
                    );
                  },
                  child: Column(
                    children: [
                      Icon(Icons.calendar_today),
                      Text('Calendário', style: TextStyle(fontSize: 10)),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ResponsiveNucleosPage()),
                    );
                  },
                  child: Column(
                    children: [
                      Icon(Icons.group),
                      Text('Grupos', style: TextStyle(fontSize: 10)),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ResponsiveFeedPage()),
                    );
                  },
                  child: Column(
                    children: [
                      Icon(Icons.list_alt_outlined),
                      Text('Feed', style: TextStyle(fontSize: 10)),
                    ],
                  ),
                ),
                SizedBox(height: 5),
              ],
            ),



            PopupMenuButton(
            icon: const Icon(Icons.person, color: Colors.black),
            color: Colors.white,
            offset: const Offset(0, kToolbarHeight),
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                child: Container(
                  color: Colors.white,
                  // Set the background color of the menu item to white
                  child: ListTile(
                    leading: Theme(
                      data: ThemeData(
                        iconTheme: const IconThemeData(color: Colors.grey),
                      ),
                      child: const Icon(Icons.person),
                    ),
                    title: const Text('Profile'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfileScaffold(
                            name: 'John Doe',
                            imageAssetPath: 'assets/images/profile.jpg',
                            role: 'Developer',
                            year: '2002',
                            nucleos: 'Engineering',
                          ),

                          /**
                              ResponsiveLayout(
                              mobileScaffold: MobileProfileScaffold(
                              name: 'John Doe',
                              imageAssetPath: 'assets/images/profile.jpg',
                              role: 'Developer',
                              year: '2002',
                              nucleos: 'Engineering',
                              ),
                              tabletScaffold: TabletProfileScaffold(
                              name: 'John Doe',
                              imageAssetPath: 'assets/images/profile.jpg',
                              role: 'Developer',
                              year: '2002',
                              nucleos: 'Engineering',
                              ),
                              desktopScaffold: DesktopProfileScaffold(
                              name: 'John Doe',
                              imageAssetPath: 'assets/images/profile.jpg',
                              role: 'Developer',
                              year: '2002',
                              nucleos: 'Engineering',
                              ),
                              ),
                           **/
                        ),
                      );
                    },
                  ),
                ),
              ),
              PopupMenuItem(
                child: Container(
                  color: Colors.white,
                  // Set the background color of the menu item to white
                  child: ListTile(
                    leading: const Icon(Icons.notification_add_outlined),
                    title: const Text('Notify'),
                    onTap: () {
                      // Handle logout button click
                      Navigator.pop(context); // Close the menu
                      // Implement your logic here
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ResponsiveReportsPage()),
                      );
                    },
                  ),
                ),
              ),
              PopupMenuItem(
                child: Container(
                  color: Colors.white,
                  // Set the background color of the menu item to white
                  child: ListTile(
                    leading: const Icon(Icons.report),
                    title: const Text('Report'),
                    onTap: () {
                      // Handle logout button click
                      Navigator.pop(context); // Close the menu
                      // Implement your logic here
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  ResponsiveAnomalyPage()),
                      );
                    },
                  ),
                ),
              ),
              PopupMenuItem(
                child: Container(
                  color: Colors.white,
                  // Set the background color of the menu item to white
                  child: ListTile(
                    leading: const Icon(Icons.admin_panel_settings),
                    title: const Text('Back-Office'),
                    onTap: () {
                      // Handle logout button click
                      Navigator.pop(context); // Close the menu
                      // Implement your logic here
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  ResponsiveBackOffice()),
                      );
                    },
                  ),
                ),
              ),
              PopupMenuItem(
                child: Container(
                  color: Colors.white,
                  // Set the background color of the menu item to white
                  child: ListTile(
                    leading: const Icon(Icons.workspaces),
                    title: const Text('Workspace'),
                    onTap: () {
                      // Handle logout button click
                      Navigator.pop(context); // Close the menu
                      // Implement your logic here
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ResponsiveReservaSalas()),
                      );
                    },
                  ),
                ),
              ),
              PopupMenuItem(
                child: Container(
                  color: Colors.white,
                  // Set the background color of the menu item to white
                  child: ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('Logout'),
                    onTap: () {
                      // Handle logout button click
                      Navigator.pop(context); // Close the menu
                      logoutButtonPressed(context);
                      print("Logout click");
                      // Implement your logic here
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
    );
  }
}
