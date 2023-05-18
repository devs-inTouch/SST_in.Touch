import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget{
  final Widget mobileProfileScaffold;
  final Widget tabletProfileScaffold;
  final Widget desktopProfileScaffold;

  ResponsiveLayout ({
    required this.mobileProfileScaffold,
    required this.tabletProfileScaffold,
    required this.desktopProfileScaffold,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if(constraints.maxWidth<700){
        return mobileProfileScaffold;
      }else if(constraints.maxWidth<1100){
        return tabletProfileScaffold;
      }else{
        return desktopProfileScaffold;
      }
    },);
  }}
