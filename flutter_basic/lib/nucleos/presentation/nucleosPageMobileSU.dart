import 'package:flutter/material.dart';
import 'package:flutter_basic/nucleos/presentation/nucleosCriacaoPage.dart';
import '../../bottomAppBarMobile.dart';
import '../../constants.dart';
import '../../myAppBarMobile.dart';
import 'nucleosBox.dart';

class NucleosPageMobileSU extends StatelessWidget {
  final List<String> nucleosList = [
    'Núcleo 1',
    'Núcleo 2',
    'Núcleo 3',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBarMobile(),
      backgroundColor: myBackground,
      body: Center(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Scrollbar(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Text(
                    "LISTA DE NÚCLEOS",
                    textAlign: TextAlign.center,
                    style:TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 35),
                  ),
                  SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: nucleosList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.all(10.0),
                        child: NucleosBox(nucleosList[index]),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: MyBottomAppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NucleosCriacaoPage(),
            ),
          );        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
