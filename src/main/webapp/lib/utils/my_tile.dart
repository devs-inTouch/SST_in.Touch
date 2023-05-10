import 'package:flutter/material.dart';
import 'package:flutter_basic/constants.dart';

class MyTile extends StatelessWidget{
  const MyTile ({Key? key}) : super(key:key);


  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: boxDecoration,
        height: 80,
      ),
    ) ;
  }
}


