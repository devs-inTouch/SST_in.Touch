import 'package:flutter/material.dart';
import 'package:flutter_basic/backoffice/presentation/responsive_backOffice.dart';
import '../../../anomalies/presentation/anomalyBox.dart';
import '../../../constants.dart';
import '../../../myAppBar.dart';
import '../../boxes/anomalyBox.dart';
import '../../presentation/backOfficePage.dart';
import '../application/anomaliesAuth.dart';

class AnomaliasVerifyPage extends StatefulWidget {
  const AnomaliasVerifyPage({super.key});
  @override
  AnomaliasVerifyPageState createState() => AnomaliasVerifyPageState();
}

class AnomaliasVerifyPageState extends State<AnomaliasVerifyPage> {
  List<AnomalyBoxBO> anomalias = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await AnomaliesAuth.getAnomaliesToAprove();
    setState(() {
      anomalias = response;
    });
    print("Anomalias por enviar fetched");
    print(anomalias);
    if (anomalias.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Sem anomalias por verificar"),
            content: Text("Não há anomalias para enviar."),
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
        padding: EdgeInsets.fromLTRB(16.0, 40.0, 16.0, 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(0.0,20.0,0.0,10.0),
              color: Colors.grey[300],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "VERIFICAÇÃO DE ANOMALIAS PENDENTES",
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
              padding: EdgeInsets.fromLTRB(0.0,10.0,0.0,10.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "ANOMALIAS:",
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
              height: 600,
              child: Scrollbar(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: anomalias.length,
                  itemBuilder: (BuildContext context, int index) {
                    final user = anomalias[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: user,
                    );
                  },
                ),
              ),
            ),



          ],
        ),
      ),
    );
  }
}
