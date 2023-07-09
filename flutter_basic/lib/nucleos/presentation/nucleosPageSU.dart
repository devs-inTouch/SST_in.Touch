import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../myAppBar.dart';
import 'nucleosBox.dart';
import 'nucleosCriacaoPage.dart';

class NucleosPageSU extends StatelessWidget {
  final List<String> nucleosList = [
    'Núcleo 1',
    'Núcleo 2',
    'Núcleo 3',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
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
                    style: TextStyle(
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
                        child: NucleosBox( nucleosList[index]),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
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
