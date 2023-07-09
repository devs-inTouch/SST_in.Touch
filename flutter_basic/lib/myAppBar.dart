import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basic/anomalies/presentation/anomaliesPage.dart';
import 'package:flutter_basic/backoffice/presentation/backOfficePage.dart';
import 'package:flutter_basic/constants.dart';
import 'package:flutter_basic/feeds/presentation/feedPage.dart';
import 'package:flutter_basic/login/presentation/loginPage.dart';
import 'package:flutter_basic/mainpage/presentation/desktop_main_scaffold.dart';
import 'package:flutter_basic/mainpage/presentation/mobile_main_scaffold.dart';
import 'package:flutter_basic/mainpage/presentation/responsive_main_page.dart';
import 'package:flutter_basic/mainpage/presentation/tablet_main_scaffold.dart';
import 'package:flutter_basic/nucleos/presentation/nucleosPage.dart';
import 'package:flutter_basic/profile/application/profleRequests.dart';
import 'package:flutter_basic/profile/presentation/profile_scaffold.dart';
import 'package:flutter_basic/reports/presentation/reportsPage.dart';
import 'package:flutter_basic/reservaSalas/presentation/responsive_reservasalas.dart';
import 'package:flutter_basic/searchBarPage/presentation/responsive_searchPage.dart';
import 'package:flutter_basic/teste/teste.dart';
import 'package:flutter_basic/maps/lib/map.dart';
import 'package:image_network/image_network.dart';
import 'mainpage/application/logoutAuth.dart';
import 'messages/application/chatScreen.dart';
import 'notifications/presentation/notificationList.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {

  @override
  _MyAppBarState createState() => _MyAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _MyAppBarState extends State<MyAppBar> {



  final TextEditingController searchValue = TextEditingController();
  List received = [];



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



  handleSearch() async{
    //List searchResults = await ProfileRequests.getSearch(searchValue.text);
    List searchResults = ['gui'];
    setState(() {
      if(mounted) {
        received = searchResults;
      }
    });


  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ProfileScaffold(
                name: 'John Doe',
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
        PopupMenuButton(
          icon: Icon(Icons.search, color: Colors.black,),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                    child: Container(
                      color: Colors.white,
                      height: 500,
                      width: 400,
                      child:Column(
                        children: [
                          TextFormField(
                            controller: searchValue,
                            decoration: InputDecoration(
                              hintText: "Pesquisa utilizadores",
                              filled: true,
                              prefixIcon: Icon(Icons.account_box),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.search),
                                onPressed: handleSearch,
                              ),
                            ),
                          ),



                        ],
                      )
                    )
                )
              ];

        }),
        Expanded(
          child:ListView.builder(
              itemCount: received.length,
              itemBuilder: (BuildContext context, int index) {
                final suggestion = received[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.orange,
                    //backgroundImage: CachedNetworkImageProvider(''),
                  ),
                  title: Text(suggestion),

                );
              }
          ),),
        IconButton(
          icon: Icon(Icons.person_search, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ResponsiveSearchPage()),
            );
          },
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
        PopupMenuButton(
          icon: const Icon(Icons.list, color: Colors.black),
          color: Colors.white,
          offset: const Offset(0, kToolbarHeight),
          itemBuilder: (BuildContext context) => [
            PopupMenuItem(
              child: Container(
                color: Colors
                    .white, // Set the background color of the menu item to white
                child: ListTile(
                  leading: const Icon(Icons.feed),
                  title: const Text('Feed'),
                  onTap: () {
                    // Handle logout button click
                    Navigator.pop(context); // Close the menu
                    // Implement your logic here
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FeedsPage()),
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
                  leading: const Icon(Icons.map),
                  title: const Text('Maps'),
                  onTap: () {
                    // Handle logout button click
                    Navigator.pop(context); // Close the menu
                    // Implement your logic here
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const GMap()),
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
                  leading: const Icon(Icons.terminal),
                  title: const Text('Tests'),
                  onTap: () {
                    // Handle logout button click
                    Navigator.pop(context); // Close the menu
                    // Implement your logic here
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Test()),
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
                  leading: const Icon(Icons.groups),
                  title: const Text('Núcleos'),
                  onTap: () {
                    // Handle logout button click
                    Navigator.pop(context); // Close the menu
                    // Implement your logic here
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NucleosPage()),
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
                          name: '',

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
                      MaterialPageRoute(
                          builder: (context) => const AnomaliesPage()),
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
                  leading: const Icon(Icons.admin_panel_settings),
                  title: const Text('Back-Office'),
                  onTap: () {
                    // Handle logout button click
                    Navigator.pop(context); // Close the menu
                    // Implement your logic here
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BackOffice()),
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
                      MaterialPageRoute(
                          builder: (context) => ResponsiveReservaSalas()),
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
    );

  }
}



