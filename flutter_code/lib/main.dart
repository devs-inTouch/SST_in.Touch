import 'package:flutter/material.dart';
import 'package:flutter_basic/responsive_mainpage/presentation/desktop_scaffold.dart';
import 'package:flutter_basic/responsive_mainpage/presentation/mobile_scaffold.dart';
import 'package:flutter_basic/responsive_mainpage/presentation/responsive_page.dart';
import 'package:flutter_basic/responsive_mainpage/presentation/tablet_scaffold.dart';


import 'login/presentation/loginPage.dart';


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

