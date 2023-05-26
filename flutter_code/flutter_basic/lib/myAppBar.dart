import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basic/maps/maps.dart';
import 'package:flutter_basic/responsive_mainpage/presentation/desktop_scaffold.dart';
import 'package:flutter_basic/responsive_mainpage/presentation/mobile_scaffold.dart';
import 'package:flutter_basic/responsive_mainpage/presentation/responsive_page.dart';
import 'package:flutter_basic/responsive_mainpage/presentation/tablet_scaffold.dart';
import 'package:flutter_basic/responsive_messages/chatScreen.dart';
import 'package:flutter_basic/responsive_profile/presentation/desktop_profile_scaffold.dart';
import 'package:flutter_basic/responsive_profile/presentation/mobile_profile_scaffold.dart';
import 'package:flutter_basic/responsive_profile/presentation/tablet_profile_scaffold.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue[800],
      leading: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>ResponsiveLayout(
                mobileScaffold: const MobileScaffold(),
                tabletScaffold: const TabletScaffold(),
                desktopScaffold: const DesktopScaffold(),

              ),
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.only(left: 20.0), // Adjust the left padding as needed
          child: Container(
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
              MaterialPageRoute(
                  builder: (context) => MapScreen()
              ),
            );
          },
          icon: Icon(Icons.map),
        ),
        IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                builder: (context) => ChatScreen(
              conversation: null,
              onConversationSelected: (Conversation) {},
            )
                ),
            );
          },
          icon: Icon(Icons.chat),
        ),
        IconButton(
          onPressed: () {
            // Handle notification icon click
          },
          icon: Icon(Icons.notifications),
        ),
        PopupMenuButton(
          icon: Icon(Icons.person),
          offset: Offset(0, kToolbarHeight),
          itemBuilder: (BuildContext context) => [
            PopupMenuItem(
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text('Profile'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResponsiveLayout(
                        mobileScaffold: const MobileProfileScaffold(
                          name: 'John Doe',
                          imageAssetPath: 'assets/images/profile.jpg',
                          role: 'Developer',
                          year: '2002',
                          nucleos: 'Engineering',
                        ),
                        tabletScaffold: const TabletProfileScaffold(
                          name: 'John Doe',
                          imageAssetPath: 'assets/images/profile.jpg',
                          role: 'Developer',
                          year: '2002',
                          nucleos: 'Engineering',
                        ),
                        desktopScaffold: const DesktopProfileScaffold(
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
                leading: Icon(Icons.logout),
                title: Text('Logout'),
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
