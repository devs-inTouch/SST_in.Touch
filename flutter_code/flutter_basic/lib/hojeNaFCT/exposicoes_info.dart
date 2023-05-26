
import 'package:flutter/material.dart';

import '../constants.dart';

class ExposicoesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        width: 500,
        decoration: boxDecoration,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Exposições',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Exposição 1',
                  style: TextStyle(fontSize: 16),
                ),
              ),

              SizedBox(height: 10.0),
            ],
          ),
        ),
      ),
    );
  }
}
