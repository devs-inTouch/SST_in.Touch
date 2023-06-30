import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basic/feeds/presentation/notificationBox.dart';

import '../application/notificationAuth.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  State<NotificationPage> createState() => NotificationState();
}

class NotificationState extends State<NotificationPage> {
  List notificationList = [];

  void initState() {
    super.initState();
    fetchNotifications();
  }

  void fetchNotifications() async {
    final response = await NotificationAuth.getNotificationsList();
    setState(() {
      notificationList = response;
    });
    print("Anomalies fetched");
    print(notificationList);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: ListView.builder(
              itemCount: notificationList.length,
              itemBuilder: (BuildContext context, int index) {
                final notification = notificationList[index];
                return Container(
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
                );
              },
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(10.0),
          child: TextButton(
            onPressed: () {
              if (notificationList.length == 0) {
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
                if (notificationList.length > 0) {
                  NotificationAuth.deleteNotifications();
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
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return SimpleDialog(
                          title: Center(
                            child: Text('Erro'),
                          ),
                          children: [
                            Center(
                              child: Text("Tente novamente"),
                            ),
                          ],
                        );
                      },
                    );
                  }
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
