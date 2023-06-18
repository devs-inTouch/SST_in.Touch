import 'package:flutter/material.dart';
import 'package:flutter_basic/profile/presentation/desktop_profile_scaffold.dart';
import 'package:flutter_basic/profile/presentation/mobile_profile_scaffold.dart';
import 'package:flutter_basic/profile/presentation/responsive_profile.dart';
import 'package:flutter_basic/profile/presentation/tablet_profile_scaffold.dart';
import 'package:flutter_basic/test.dart';

import 'mainpage/presentation/desktop_main_scaffold.dart';
import 'mainpage/presentation/mobile_main_scaffold.dart';
import 'mainpage/presentation/tablet_main_scaffold.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ResponsiveLayout(
        mobileProfileScaffold: MobileScaffold(),
        tabletProfileScaffold: TabletScaffold(),
        desktopProfileScaffold: DesktopScaffold(),
      ),
    );
  }
}
