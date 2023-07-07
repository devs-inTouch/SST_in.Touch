import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../myAppBar.dart';
import '../application/activateUsersAuth.dart';
import 'backOfficePage.dart';
import 'boxes/usersToActivateBox.dart';



  class AtivacaoContasPage extends StatefulWidget {
  const AtivacaoContasPage({super.key});
  @override
  ContasPageState createState() => ContasPageState();
  }
  class ContasPageState extends State<AtivacaoContasPage> {
  List contasPorAtivarList = [];
  bool showNotifications = true;

  @override
  void initState() {
  super.initState();
  fetchNotifications();
  }

  void fetchNotifications() async {
  final response = await ActivateUsersAuth.getUsersToActivate();
  setState(() {
    contasPorAtivarList = response;
  });
  print("Contas por ativar fetched");
  print(contasPorAtivarList);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  MyAppBar(),
      backgroundColor: myBackground,
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              color: Colors.grey[300],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "ATIVAÇÃO DE CONTAS",
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
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "CONTA:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              width: 800,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: contasPorAtivarList.length,
                itemBuilder: (BuildContext context, int index) {
                  UsersToAtivateBox usersToAtivateBox = contasPorAtivarList[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: UsersToAtivateBox(
                      targetUsername: usersToAtivateBox.targetUsername,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
