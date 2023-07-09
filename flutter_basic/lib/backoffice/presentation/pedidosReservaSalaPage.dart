import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../myAppBar.dart';
import 'backOfficePage.dart';

class PedidoReservaSalaPage extends StatelessWidget {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "PEDIDOS E RESERVAS DE SALAS",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
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
            SizedBox(height: 10.0),
            Text(
              "SALA:",
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 10.0),
            Container(
              width: double.infinity,
              height: 200.0,
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
