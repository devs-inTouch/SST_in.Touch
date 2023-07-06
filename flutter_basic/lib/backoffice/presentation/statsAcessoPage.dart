import 'package:flutter/material.dart';
import 'package:flutter_basic/backoffice/presentation/backOfficePage.dart';
import '../../constants.dart';
import '../../myAppBar.dart';
import '../application/statsValueAuth.dart';



  class StatsAcessoPage extends StatefulWidget {
  const StatsAcessoPage({super.key});
  @override
  NotificationState createState() => NotificationState();
  }

  class NotificationState extends State<StatsAcessoPage> {
  List statsList = [];

  @override
  void initState() {
    super.initState();
    fetchStats();
  }

  void fetchStats() async {
    final response = await StatsValueAuth.getStats();
    setState(() {
      statsList = response;
    });
    print("stats fetched");
    print(statsList);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      backgroundColor: myBackground,
      body: Container(
        padding: EdgeInsets.fromLTRB(16.0, 40.0, 16.0, 16.0), // Updated padding
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              color: Colors.grey[300],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "ESTATÍSTICA E CONTROLO DE ACESSOS",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BackOffice()),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              width: 800,
              height: 500,
              padding: EdgeInsets.all(16.0),
              color: Colors.blueAccent[100],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    color: Colors.white70,
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            "Users online:",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 16.0),
                          child: Container(
                            width: 100.0,
                            height: 40.0,
                            color: Colors.white,
                            child: Center(
                              child: Text(
                                statsList.isNotEmpty ? statsList[0].toString() : 'N/A',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    color: Colors.white70,
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            "Posts realizados:",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 16.0),
                          child: Container(
                            width: 100.0,
                            height: 40.0,
                            color: Colors.white,
                            child: Center(
                              child: Text(
                                statsList.isNotEmpty ? statsList[1].toString() : 'N/A',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    color: Colors.white70,
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            "Reports por rever:",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 16.0),
                          child: Container(
                            width: 100.0,
                            height: 40.0,
                            color: Colors.white,
                            child: Center(
                              child: Text(
                                statsList.isNotEmpty ? statsList[2].toString() : 'N/A',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    color: Colors.white70,
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            "Contas por Ativar:",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 16.0),
                          child: Container(
                            width: 100.0,
                            height: 40.0,
                            color: Colors.white,
                            child: Center(
                              child: Text(
                                statsList.isNotEmpty ? statsList[0].onlineUsers.toString() : 'N/A',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    color: Colors.white70,
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            "Pedidos de reserva por Rever:",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 16.0),
                          child: Container(
                            width: 100.0,
                            height: 40.0,
                            color: Colors.white,
                            child: Center(
                              child: Text(
                                statsList.isNotEmpty ? statsList[0].onlineUsers.toString() : 'N/A',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
