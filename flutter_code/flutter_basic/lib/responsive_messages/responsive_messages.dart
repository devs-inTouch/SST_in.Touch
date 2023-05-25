import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget{
  final Widget mobileMessagesScaffold;
  final Widget tabletMessagesScaffold;
  final Widget desktopMessagesScaffold;

  const ResponsiveLayout ({super.key, 
    required this.desktopMessagesScaffold,
    required this.mobileMessagesScaffold,
    required this.tabletMessagesScaffold,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if(constraints.maxWidth<600){
        return mobileMessagesScaffold;
      }else if(constraints.maxWidth<1100){
        return tabletMessagesScaffold;
      }else{
        return desktopMessagesScaffold;
      }
    },);
  }}
