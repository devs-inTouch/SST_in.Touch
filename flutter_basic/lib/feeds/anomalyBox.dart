import 'package:flutter/material.dart';

class AnomalyBox extends StatelessWidget{

  final String text;
  final double fem;

  const AnomalyBox({
    required this.text,
    required this.fem
  });

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.symmetric(vertical: 4.0),
        child: Container(
            height: 200 * fem,
            width: 650* fem,
            decoration: BoxDecoration(
                color: Colors.red
            ), child: Stack(
          children: [
            Align(
                alignment: Alignment(-0.95, -0.9),
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: Colors.white
                  ),
                )
            ),
            Align(
                alignment: Alignment(-0.75, -0.9),
                child: Text(
                    "username"
                )
            ),
            Align(
                alignment: Alignment(0.0, -0.9),
                child: Text(
                    "Title"
                )
            ),
            Align(
              alignment: Alignment(0.9,-0.85) ,
              child: Text(
                "HORA",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14
                ),
              ),
            ),
            Align(
              alignment: Alignment(0.0,0.0),
              child: Text(
                "ola",
                textAlign: TextAlign.left,
              ),
            )
          ],
        )
        )
    );
  }

}