
import 'package:flutter/material.dart';

class ProfileBox extends StatelessWidget {

  final double fem;
  final List map;


  const ProfileBox({
    required this.fem,
    required this.map
  });


  @override
  Widget build(BuildContext context) {

    return Container(
      height: 300* fem,
      width: 650 * fem,
      decoration: BoxDecoration(
          color: Colors.grey.shade200
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment(-0.9,-0.6),
            child: Container(
              height: 175* fem,
              width: 150* fem,
              decoration: BoxDecoration(
                color: Colors.blue
              ),
            ),
          ),
          Align(
            alignment: Alignment(-0.35, -0.8),
            child: Text(
              map[4],style: TextStyle(
              fontSize: 15
            ),

            )
          ),
          Align(
            alignment: Alignment(0.1, -0.2),
            child: Container(
              width: 290 * fem ,
              height: 135 * fem,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,

              ),
              child: Text(
                map[2],

              ),
            ),
          ),
          Align(
            alignment: Alignment(0.9,-0.8),

            child: OutlinedButton(
              onPressed: () {  },
              style: OutlinedButton.styleFrom(
                fixedSize: Size(100* fem, 50* fem),
                backgroundColor: Colors.blue
              ), child: Text(
              'SEGUIR',
              textAlign: TextAlign.left,
              style: TextStyle(
              color: Colors.white,
              fontSize: 15

            ),
            ),


            ),
          ),

          Align(
            alignment: Alignment(-0.8,0.9),
            child: Container(
              height: 85* fem,
              width: 400* fem,
              decoration: BoxDecoration(
                color: Colors.grey.shade200
              ), child: Text('NUCLEOS'),
            )
          ),
          Align(
            alignment: Alignment(0.95,0),
            child: Container(
              width: 120* fem,
              height: 125* fem,
              decoration: BoxDecoration(
                color: Colors.grey.shade200
              ), child: Text(map[5] + '\n' + map[1], textAlign: TextAlign.center, ),
           )
          )
          
        ],
      ),
    );
  }
  
}