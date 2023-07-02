import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../myAppBar.dart';

class NucleosBox extends StatelessWidget {
  NucleosBox(String nucleosList);

  @override
  Widget build(BuildContext context) {
    return
      Container(
        width: 250,
        height: 500,
        color: Colors.grey[300],
        child: Column(
          children: [
            SizedBox(height: 10),
            Container(
              width: 150,
              height: 150,
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.rectangle,
              ),
// TODO: imagem do núcleo
            ),
            SizedBox(height: 10),
            Container(
              width: 180,
              child: Text(
                "Title",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
// TODO: nome do núcleo
            ),
            SizedBox(height: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 200,
                  height: 130,
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                  ),
// TODO: descrição do núcleo
                ),
                SizedBox(height: 10),
                Container(
                  width: 200,
                  height: 130,
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                  ),
// TODO: socials do núcleo
                ),
              ],
            ),
          ],
        ),
      );
  }
}











