import 'package:flutter/material.dart';
import 'package:flutter_basic/constants.dart';
import 'package:flutter_basic/myAppBarMobile.dart';
import '../../bottomAppBarMobile.dart';
import '../../myAppBar.dart';

class ReportsPageMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: MyAppBarMobile(),
      backgroundColor: myBackground,
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'ENVIAR AVISO',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: FractionallySizedBox(
                  widthFactor: screenWidth < 700 ? 1.0 : 0.8,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blueAccent[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 7,
                              child: Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: EdgeInsetsDirectional.zero,
                                  child: Text(
                                    'TÍTULO',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              flex: 16,
                              child: TextField(
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              flex: 7,
                              child: Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: EdgeInsetsDirectional.zero,
                                  child: Text(
                                    'DESCRIÇÃO',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              flex: 16,
                              child: TextField(
                                maxLines: 8,
                                textAlignVertical: TextAlignVertical.top,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.all(10),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              flex: 7,
                              child: Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: EdgeInsetsDirectional.zero,
                                  child: Text(
                                    'ENVIAR PARA',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              flex: 16,
                              child: TextField(
                                maxLines: null,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: () {
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent[200]!),
                ),
                child: Text(
                  'ENVIAR NOTIFICAÇÕES',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
      bottomNavigationBar: MyBottomAppBar(),
    );
  }
}



