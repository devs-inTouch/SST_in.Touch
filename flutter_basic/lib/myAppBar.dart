import 'package:flutter/material.dart';
import 'package:flutter_basic/anomalies/presentation/anomaliesPage.dart';
import 'package:flutter_basic/feeds/presentation/responsiveFeed.dart';
import 'package:flutter_basic/maps/maps.dart';
import 'package:flutter_basic/mainpage/presentation/desktop_main_scaffold.dart';
import 'package:flutter_basic/mainpage/presentation/mobile_main_scaffold.dart';
import 'package:flutter_basic/mainpage/presentation/responsive_main_page.dart';
import 'package:flutter_basic/mainpage/presentation/tablet_main_scaffold.dart';
import 'package:flutter_basic/profile/presentation/desktop_profile_scaffold.dart';
import 'package:flutter_basic/profile/presentation/mobile_profile_scaffold.dart';
import 'package:flutter_basic/profile/presentation/tablet_profile_scaffold.dart';
import 'package:flutter_basic/reports/presentation/reportsPage.dart';
import 'package:flutter_basic/reservaSalas/presentation/responsive_reservasalas.dart';
import 'package:flutter_basic/reservaSalas/presentation/tablet_reservasalas_page.dart';
import 'package:flutter_basic/teste/teste.dart';

import 'feeds/presentation/feedPage.dart';
import 'messages/application/chatScreen.dart';
import 'notifications/presentation/notificationList.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: GestureDetector(
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
          child: Row(
            children: [
              Image.asset(
                'assets/logo-1-RBH.png',
                height: 35, // Defina a altura desejada para a imagem
              ),
            ],
          ),
        ),
      ),
      actions: [
        IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ResponsiveFeed()),
              );
            },
            icon: Icon(Icons.feed),
            color: Colors.black),
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MapScreen()),
            );
          },
          icon: const Icon(Icons.map),
          color: Colors.black,
        ),
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Test()),
            );
          },
          icon: const Icon(Icons.temple_buddhist),
          color: Colors.black,
        ),
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatScreen(
                        conversation: null,
                        onConversationSelected: (Conversation) {},
                      )),
            );
          },
          icon: const Icon(Icons.chat),
          color: Colors.black,
        ),
        PopupMenuButton<Notification>(
          icon: Icon(Icons.notifications, color: Colors.black),
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
                    child: SizedBox(
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
          icon: const Icon(Icons.person, color: Colors.black),
          color: Colors.white,
          offset: const Offset(0, kToolbarHeight),
          itemBuilder: (BuildContext context) => [
            PopupMenuItem(
              child: Container(
                color: Colors
                    .white, // Set the background color of the menu item to white
                child: ListTile(
                  leading: Theme(
                    data: ThemeData(
                      iconTheme: IconThemeData(color: Colors.grey),
                    ),
                    child: const Icon(Icons.person),
                  ),
                  title: const Text('Profile'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ResponsiveLayout(
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
                      ),
                    );
                  },
                ),
              ),
            ),
            PopupMenuItem(
              child: Container(
                color: Colors
                    .white, // Set the background color of the menu item to white
                child: ListTile(
                  leading: const Icon(Icons.notification_add_outlined),
                  title: const Text('Notify'),
                  onTap: () {
                    // Handle logout button click
                    Navigator.pop(context); // Close the menu
                    // Implement your logic here
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ReportsPage()),
                    );
                  },
                ),
              ),
            ),
            PopupMenuItem(
              child: Container(
                color: Colors
                    .white, // Set the background color of the menu item to white
                child: ListTile(
                  leading: const Icon(Icons.report),
                  title: const Text('Report'),
                  onTap: () {
                    // Handle logout button click
                    Navigator.pop(context); // Close the menu
                    // Implement your logic here
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AnomaliesPage()),
                    );
                  },
                ),
              ),
            ),
            PopupMenuItem(
              child: Container(
                color: Colors
                    .white, // Set the background color of the menu item to white
                child: ListTile(
                  leading: const Icon(Icons.workspaces),
                  title: const Text('Workspace'),
                  onTap: () {
                    // Handle logout button click
                    Navigator.pop(context); // Close the menu
                    // Implement your logic here
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ResponsiveReservaSalas()),
                    );
                  },
                ),
              ),
            ),
            PopupMenuItem(
              child: Container(
                color: Colors
                    .white, // Set the background color of the menu item to white
                child: ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Logout'),
                  onTap: () {
                    // Handle logout button click
                    Navigator.pop(context); // Close the menu
                    // Implement your logic here
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


