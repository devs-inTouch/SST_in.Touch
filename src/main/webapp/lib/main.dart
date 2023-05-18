import 'package:flutter/material.dart';
import 'package:flutter_basic/responsive_mainpage/desktop_scaffold.dart';
import 'package:flutter_basic/responsive_mainpage/mobile_scaffold.dart';
import 'package:flutter_basic/responsive_mainpage/responsive_page.dart';
import 'package:flutter_basic/responsive_mainpage/tablet_scaffold.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp ({Key? key}) : super(key: key);

  @override
  Widget build (BuildContext context){
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ResponsiveLayout(
        mobileScaffold:const  MobileScaffold(),
        tabletScaffold:const TabletScaffold(),
        desktopScaffold:const DesktopScaffold(),
      ),
    );
  }
}