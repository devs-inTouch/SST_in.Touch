import 'package:flutter/material.dart';
import 'package:flutter_basic/responsive_mainpage/desktop_scaffold.dart';
import 'package:flutter_basic/responsive_mainpage/mobile_scaffold.dart';
import 'package:flutter_basic/responsive_mainpage/responsive_page.dart';
import 'package:flutter_basic/responsive_messages/chatScreen.dart';
import 'package:flutter_basic/responsive_profile/presentation/desktop_profile_scaffold.dart';
import 'package:flutter_basic/responsive_mainpage/tablet_scaffold.dart';
import 'package:flutter_basic/responsive_profile/presentation/mobile_profile_scaffold.dart';
import 'package:flutter_basic/responsive_profile/presentation/tablet_profile_scaffold.dart';
import 'login/presentation/loginPage.dart';

var myBackground = Colors.white;

var textStyleBar = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.bold,
);

final buttonStyle = ElevatedButton.styleFrom(
  backgroundColor: Colors.blue.withOpacity(0.3),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0),
  ),
);

var topBarDecoration = BoxDecoration(
  color: Colors.grey[300],
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(10),
    topRight: Radius.circular(10),
  ),
);

var boxMainMenuDecoration = BoxDecoration(
  border: Border.all(color: Colors.black),
  color: Colors.blue.withOpacity(0.3),
  borderRadius: BorderRadius.circular(10),
);

var boxDecoration = BoxDecoration(
  border: Border.all(color: Colors.black),
  color: Colors.grey[100],
  borderRadius: BorderRadius.circular(10),
);

var topBarProfile = ({
  required String text,
}) =>
    Align(
      alignment: Alignment.topLeft,
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: Container(
          decoration: topBarDecoration,
          padding: EdgeInsets.only(left: 16),
          // Add padding to align text to the left
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );

var myAppBar = AppBar(
  backgroundColor: Colors.blue[800],
  flexibleSpace: FlexibleSpaceBar(
    centerTitle: true,
    title: Container(
      height: 60, // set height of the container
      width: 60, // set width of the container
      child: Image.asset('assets/logo-1-RBH.png', fit: BoxFit.contain),
    ),
  ),
);
var myDrawer = Drawer(
  backgroundColor: Colors.blue[600],
  width: 220,
  child: Builder(
    builder: (BuildContext context) {
      return Column(
        children: [
          DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logo-1-RBH.png',
                  width: 50,
                  height: 50,
                ),
                SizedBox(height: 10),
                InkWell(
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
                  child: Text(
                    'Profile',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          InkWell(
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
            child: ListTile(
              leading: Icon(Icons.home),
              title: Text(
                'H O M E  P A G E',
                style: TextStyle(color: Colors.white),
              ),
              tileColor: Colors.blue[900],
              selectedTileColor: Colors.blue[800],
              selected: true,
            ),
          ),
          SizedBox(height: 10),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatScreen(
                          conversation: null,
                          onConversationSelected: (Conversation) {},
                        )

                    /** MaterialPageRoute(
                      builder: (context) => ResponsiveLayout(
                      mobileMessagesScaffold: MobileMessagesScaffold(
                      conversation: Conversation(
                      name: 'John Doe',
                      message: 'assets/images/profile.jpg',
                      isGroupChat: false,
                      ),
                      ),
                      tabletMessagesScaffold: TabletMessagesScaffold(
                      conversation: Conversation(
                      name: 'John Doe',
                      message: 'assets/images/profile.jpg',
                      isGroupChat: false,
                      ),
                      ),
                      desktopMessagesScaffold: DesktopMessagesScaffold(
                      conversation: Conversation(
                      name: 'John Doe',
                      message: 'assets/images/profile.jpg',
                      isGroupChat: false,
                      ),
                      ),
                   **/
                    ),
              );
            },
            child: ListTile(
              leading: Icon(Icons.chat),
              title: Text(
                'M E S S A G E S',
                style: TextStyle(color: Colors.white),
              ),
              tileColor: Colors.blue[900],
              selectedTileColor: Colors.blue[800],
              selected: false, // Change to true if this is the current page
            ),
          ),
          Spacer(),
          InkWell(
            onTap: () {
              // Function to execute when the "Logout" button is tapped
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
            },
            child: ListTile(
              leading: Icon(Icons.logout),
              title: Text(
                'L O G O U T',
                style: TextStyle(color: Colors.white),
              ),
              tileColor: Colors.blue[900],
              selectedTileColor: Colors.blue[800],
              selected: false, // Change to true if this is the current page
            ),
          ),
        ],
      );
    },
  ),
);
