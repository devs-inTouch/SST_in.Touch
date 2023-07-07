import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../myAppBar.dart';
import 'nucleosBox.dart';

class NucleosPage extends StatelessWidget {
  final List<String> nucleosList = [
    'Núcleo 1',
    'Núcleo 2',
    'Núcleo 3',
    // Add more nucleos as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  MyAppBar(),
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
                      fontSize: 20.0,
                    ),
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
    );
  }
}
