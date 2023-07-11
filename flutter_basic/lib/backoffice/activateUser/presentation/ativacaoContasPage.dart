import 'package:flutter/material.dart';
import 'package:flutter_basic/backoffice/presentation/responsive_backOffice.dart';
import '../../../constants.dart';
import '../../../myAppBar.dart';
import '../../boxes/userActivateBox.dart';
import '../application/activateUsersAuth.dart';
import '../../presentation/backOfficePage.dart';

class AtivacaoContasPage extends StatefulWidget {
  const AtivacaoContasPage({super.key});
  @override
  ContasPageState createState() => ContasPageState();
}

class ContasPageState extends State<AtivacaoContasPage> {
  List<UserActivateBox> unactiveUsers = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await ActivateUsersAuth.getUsersToActivate();
    setState(() {
      unactiveUsers = response;
    });
    print("Contas por ativar fetched");
    print(unactiveUsers);

    if (unactiveUsers.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Sem contas por ativar"),
            content: Text("Não há contas por ativar."),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ResponsiveBackOffice()),
                  );
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  const Expanded(
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
                        MaterialPageRoute(
                            builder: (context) => ResponsiveBackOffice()),
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
                  "CONTAS POR ATIVAR:",
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
                itemCount: unactiveUsers.length,
                itemBuilder: (BuildContext context, int index) {
                  final user = unactiveUsers[index];
                  return user;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
