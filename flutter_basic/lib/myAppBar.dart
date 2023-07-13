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
import 'package:flutter_basic/profile/presentation/profile_scaffold_Mobile.dart';
import 'package:flutter_basic/profile/presentation/responsive_profile.dart';
import 'package:flutter_basic/reports/presentation/reportsPage.dart';
import 'package:flutter_basic/reports/presentation/responsive_reportsPage.dart';
import 'package:flutter_basic/reservaSalas/presentation/responsive_reservasalas.dart';
import 'package:flutter_basic/searchBarPage/presentation/responsive_searchPage.dart';
import 'package:flutter_basic/teste/teste.dart';
import 'package:flutter_basic/maps/lib/map.dart';
import 'anomalies/presentation/responsive_anomaliesPage.dart';
import 'backoffice/presentation/responsive_backOffice.dart';
import 'calendar/page/calendar_page.dart';
import 'calendar/page/responsive_calendar.dart';
import 'constants.dart';
import 'feeds/presentation/responsiveFeed.dart';
import 'mainpage/application/logoutAuth.dart';
import 'maps/lib/responsiveMap.dart';
import 'noticias/presentation/newsPage.dart';
import 'noticias/presentation/responsiveNewsPage.dart';
import 'notifications/presentation/notificationList.dart';
import 'nucleos/presentation/responsive_nucleos_page.dart';
import 'nucleos/presentation/responsive_nucleos_page_SU.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  _MyAppBarState createState() => _MyAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _MyAppBarState extends State<MyAppBar> {
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
    getRole().then((value) {
      setState(() {
        role = value;
      });
    });
    return AppBar(
      backgroundColor: Colors.white,
      leading: Row(
        children: [
          GestureDetector(
            onTap: () {
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
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Image.asset(
                'assets/Icon.png',
                height: 35,
              ),
            ),
          ),
        ],
      ),
      actions: [
        Expanded(
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.home, color: Colors.black),
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
                ),
                IconButton(
                  icon: Icon(Icons.person_search, color: Colors.black),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ResponsiveSearchPage()),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.map, color: Colors.black),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ResponsiveMap()),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.calendar_today, color: Colors.black),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResponsiveCalendarLayout(),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.list_alt_outlined, color: Colors.black),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ResponsiveFeedPage()),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.groups, color: Colors.black),
                  onPressed: () {
                    if (role == 'superUser' || role == 'admin') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResponsiveNucleosPageSU(),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResponsiveNucleosPage(),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        PopupMenuButton(
          icon: Icon(Icons.list, color: Colors.black),
          color: Colors.white,
          offset: Offset(0, kToolbarHeight),
          itemBuilder: (BuildContext context) => [
            PopupMenuItem(
              child: Container(
                color: Colors.white,
                child: ListTile(
                  leading: const Icon(Icons.feed),
                  title: const Text('Feed'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ResponsiveFeedPage()),
                    );
                  },
                ),
              ),
            ),
            PopupMenuItem(
              child: Container(
                color: Colors.white,
                child: ListTile(
                  leading: const Icon(Icons.map),
                  title: const Text('Maps'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ResponsiveMap()),
                    );
                  },
                ),
              ),
            ),
            /**
            PopupMenuItem(
              child: Container(
                color: Colors.white,
                child: ListTile(
                  leading: const Icon(Icons.terminal),
                  title: const Text('Tests'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ResponsiveCalendarLayout()),
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
                      MaterialPageRoute(
                          builder: (context) => ResponsiveNewsPage()),
                    );
                  },
                ),
              ),
            ),
                **/
            PopupMenuItem(
              child: Container(
                color: Colors.white,
                child: ListTile(
                  leading: const Icon(Icons.groups),
                  title: const Text('Núcleos'),
                  onTap: () {
                    Navigator.pop(context);
                    if (role == 'superUser' || role == 'admin') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResponsiveNucleosPageSU(),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResponsiveNucleosPage(),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
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
        PopupMenuButton(
          icon: Icon(Icons.person, color: Colors.black),
          color: Colors.white,
          offset: Offset(0, kToolbarHeight),
          itemBuilder: (BuildContext context) => [
            PopupMenuItem(
              child: Container(
                color: Colors.white,
                child: ListTile(
                  leading: Theme(
                    data: ThemeData(
                      iconTheme: const IconThemeData(color: Colors.grey),
                    ),
                    child: const Icon(Icons.person),
                  ),
                  title: const Text('Perfil'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResponsiveProfile(
                          mobileProfileScaffold: ProfileScaffoldMobile(
                            name: '',
                          ),
                          profileScaffold: ProfileScaffold(
                            name: '',
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            PopupMenuItem(
              child: Container(
                color: Colors.white,
                child: ListTile(
                  leading: const Icon(Icons.report),
                  title: const Text('Report de Anomalias'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ResponsiveAnomalyPage()),
                    );
                  },
                ),
              ),
            ),
            if (role == 'SEGURANÇA' ||
                role == 'admin' ||
                role == 'BIBLIOTECA' ||
                role == 'DIREÇÃO' ||
                role == 'DIVULGAÇÃO')
              PopupMenuItem(
                child: Container(
                  color: Colors.white,
                  child: ListTile(
                    leading: const Icon(Icons.admin_panel_settings),
                    title: const Text('Back-Office'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ResponsiveBackOffice()),
                      );
                    },
                  ),
                ),
              ),
            PopupMenuItem(
              child: Container(
                color: Colors.white,
                child: ListTile(
                  leading: const Icon(Icons.workspaces),
                  title: const Text('Reserva de salas'),
                  onTap: () {
                    Navigator.pop(context);
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
                child: ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Logout'),
                  onTap: () {
                    Navigator.pop(context);
                    logoutButtonPressed(context);
                    print("Logout click");
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
