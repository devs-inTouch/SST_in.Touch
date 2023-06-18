
import 'package:flutter/material.dart';
import 'package:flutter_basic/anomalies/presentation/anomaliesPage.dart';
import 'package:flutter_basic/maps/maps.dart';
import 'package:flutter_basic/mainpage/presentation/desktop_main_scaffold.dart';
import 'package:flutter_basic/mainpage/presentation/mobile_main_scaffold.dart';
import 'package:flutter_basic/mainpage/presentation/responsive_main_page.dart';
import 'package:flutter_basic/mainpage/presentation/tablet_main_scaffold.dart';
import 'package:flutter_basic/profile/presentation/desktop_profile_scaffold.dart';
import 'package:flutter_basic/profile/presentation/mobile_profile_scaffold.dart';
import 'package:flutter_basic/profile/presentation/tablet_profile_scaffold.dart';
import 'package:flutter_basic/reports/presentation/reportsPage.dart';

import 'messages/application/chatScreen.dart';

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
          padding: const EdgeInsets.only(left: 20.0),
          child: Row(
            children: [
              Image.asset(
                'assets/logo-1-RBH.png',
                height: 50, // Defina a altura desejada para a imagem
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

          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem<Notification>(
                child: Theme(
                  data: Theme.of(context).copyWith(
                    backgroundColor: Colors.blue, // Set the background color to blue
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.grey[300], // Light grey for tiles
                    ),
                    child: SizedBox(
                      height: 500,
                      width: 700,
                      child: Column(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: ListView.builder(
                                itemCount: notifications.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final notification = notifications[index];
                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[200], // Light grey for tiles
                                    ),
                                    margin: EdgeInsets.symmetric(vertical: 5.0),
                                    padding: EdgeInsets.all(10.0),
                                    child: ListTile(
                                      title: Text(notification.name),
                                      subtitle: Text(notification.time.toString()),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10.0),
                            child: TextButton(
                              onPressed: () {
                                // Add your desired action when the button is pressed
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.grey[400], // Set the same dark grey color as the background
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0), // Set the border radius
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'LIMPAR NOTIFICAÇÕES (${notifications.length})',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white, // Set the text color to white
                                  ),
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ];
          },
          onSelected: (notification) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(notification.name),
                  content: Column(
                    children: [
                      // Add content for the selected notification
                    ],
                  ),
                );
              },
            );
          },
          icon: Icon(Icons.notifications, color: Colors.black),
          color: Colors.white,
          offset: const Offset(0, kToolbarHeight),
        ),

        PopupMenuButton(
          icon: const Icon(Icons.person, color: Colors.black),
          color: Colors.white,
          offset: const Offset(0, kToolbarHeight),
          itemBuilder: (BuildContext context) => [
            PopupMenuItem(
              child: Container(
                color: Colors.white, // Set the background color of the menu item to white
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
                color: Colors.white, // Set the background color of the menu item to white
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
                color: Colors.white, // Set the background color of the menu item to white
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
                color: Colors.white, // Set the background color of the menu item to white
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

List<Notification> notifications = [
  Notification(name: 'Notification 1', time: DateTime.now()),
  Notification(name: 'Notification 2', time: DateTime.now()),
  Notification(name: 'Notification 3', time: DateTime.now()),
  Notification(name: 'Notification 4', time: DateTime.now()),
  Notification(name: 'Notification 5', time: DateTime.now()),
  Notification(name: 'Notification 6', time: DateTime.now()),
  Notification(name: 'Notification 7', time: DateTime.now()),
  Notification(name: 'Notification 8', time: DateTime.now()),
  // Add more notifications as needed
  Notification(name: 'Notification 1', time: DateTime.now()),
  Notification(name: 'Notification 2', time: DateTime.now()),
  Notification(name: 'Notification 3', time: DateTime.now()),
  Notification(name: 'Notification 4', time: DateTime.now()),
  Notification(name: 'Notification 5', time: DateTime.now()),
  Notification(name: 'Notification 6', time: DateTime.now()),
  Notification(name: 'Notification 7', time: DateTime.now()),
  Notification(name: 'Notification 8', time: DateTime.now()),
];

class Notification {
  final String name;
  final DateTime time;

  Notification({required this.name, required this.time});
}





