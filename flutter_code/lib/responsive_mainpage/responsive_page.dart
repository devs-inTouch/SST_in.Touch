import 'package:flutter/material.dart';

class MainPage extends StatelessWidget{
  final Widget mobileScaffold;
  final Widget tabletScaffold;
  final Widget desktopScaffold;

  MainPage ({
    required this.desktopScaffold,
    required this.mobileScaffold,
    required this.tabletScaffold,
  });

@override
Widget build(BuildContext context) {
  return LayoutBuilder(builder: (context, constraints) {
      if(constraints.maxWidth<600){
        return mobileScaffold;
      }else if(constraints.maxWidth<1100){
        return tabletScaffold;
      }else{
        return desktopScaffold;
      }
  },);
}}

