import 'package:flutter/material.dart';

import '../constants.dart';

class RestauracaoPage extends StatelessWidget {
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
                'Menu for Cantina X',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Menu content for Cantina X',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'Menu for Restaurante X',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Menu content for Restaurante X',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'Menu for Restaurante Y',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Menu content for Restaurante Y',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'Menu for Restaurante Z',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Menu content for Restaurante Z',
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
