import 'package:flutter/material.dart';
import 'package:flutter_basic/constants.dart';

class MyBox extends StatelessWidget{
  final Widget? child;
  const MyBox({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: boxDecoration,
      ),
    ) ;
  }
}