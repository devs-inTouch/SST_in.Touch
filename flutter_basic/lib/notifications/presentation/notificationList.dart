import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basic/feeds/presentation/notificationBox.dart';

import '../../anomalies/presentation/anomaliesPage.dart';
import '../application/notificationAuth.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});
  @override
  NotificationState createState() => NotificationState();
}
class NotificationState extends State<NotificationPage> {
  List notificationList = [];
  bool showNotifications = true;

  @override
  void initState() {
    super.initState();
    fetchNotifications();
  }

  void fetchNotifications() async {
    final response = await NotificationAuth.getNotificationsList();
    setState(() {
      notificationList = response;
    });
    print("Notifications fetched");
    print(notificationList);
  }

  void deleteNotifications() async {
    await NotificationAuth.deleteNotifications();
    setState(() {
      notificationList = [];
    });
  }

  void navigateToAnomalyPage() {
    // Navigate to the AnomalyPage when a notification is clicked
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AnomaliesPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (showNotifications) Expanded(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: ListView.builder(
              itemCount: notificationList.length,
              itemBuilder: (BuildContext context, int index) {
                final notification = notificationList[index];
                return GestureDetector(
                  onTap: () {
                    navigateToAnomalyPage(); // Call the navigation function
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.grey[200], // Light grey for tiles
                    ),
                    margin: EdgeInsets.symmetric(vertical: 5.0),
                    padding: EdgeInsets.all(10.0),
                    child: NotificationBox(
                      message: notification.message,
                      creationDate: notification.creationDate,
                    ),
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
              if (notificationList.isEmpty) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return SimpleDialog(
                      title: Center(
                        child: Text('0 Notificações'),
                      ),
                      children: [
                        Center(
                          child: Text("Não há notificações para eliminar"),
                        ),
                      ],
                    );
                  },
                );
              } else {
                deleteNotifications();
                showDialog(
                  context: context,
                  builder: (context) {
                    return SimpleDialog(
                      title: Center(
                        child: Text('Sucesso'),
                      ),
                      children: [
                        Center(
                          child: Text("Notificações apagadas"),
                        ),
                      ],
                    );
                  },
                );
                setState(() {
                  showNotifications = false; // Hide the notifications column
                });
              }
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.blueAccent[200], // Set the same dark grey color as the background
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    10.0), // Set the border radius
              ),
            ),
            child: Center(
              child: Text(
                'LIMPAR NOTIFICAÇÕES (${notificationList.length})',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Set the text color to white
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}