import 'package:flutter/material.dart';
import 'package:flutter_basic/maps/maps.dart';
import 'package:flutter_basic/mainpage/presentation/desktop_scaffold.dart';
import 'package:flutter_basic/mainpage/presentation/mobile_scaffold.dart';
import 'package:flutter_basic/mainpage/presentation/responsive_page.dart';
import 'package:flutter_basic/mainpage/presentation/tablet_scaffold.dart';
import 'package:flutter_basic/messages/chatScreen.dart';
import 'package:flutter_basic/profile/presentation/desktop_profile_scaffold.dart';
import 'package:flutter_basic/profile/presentation/mobile_profile_scaffold.dart';
import 'package:flutter_basic/profile/presentation/tablet_profile_scaffold.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue[800],
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
          padding:
              const EdgeInsets.only(left: 20.0), // Adjust the left padding as needed
          child: SizedBox(
            height: 150,
            width: 150,
            child: Image.asset('assets/logo-1-RBH.png', fit: BoxFit.contain),
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
        ),
        IconButton(
          onPressed: () {
            // Handle notification icon click
          },
          icon: const Icon(Icons.notifications),
        ),
        PopupMenuButton(
          icon: const Icon(Icons.person),
          offset: const Offset(0, kToolbarHeight),
          itemBuilder: (BuildContext context) => [
            PopupMenuItem(
              child: ListTile(
                leading: const Icon(Icons.person),
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
            PopupMenuItem(
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
          ],
        ),
      ],
    );
  }
}
