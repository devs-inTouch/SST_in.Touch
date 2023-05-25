import 'package:flutter/material.dart';
import 'package:flutter_basic/responsive_profile/presentation/desktop_profile_scaffold.dart';
import 'package:flutter_basic/responsive_profile/presentation/mobile_profile_scaffold.dart';
import 'package:flutter_basic/responsive_profile/presentation/responsive_profile.dart';
import 'package:flutter_basic/responsive_profile/presentation/tablet_profile_scaffold.dart';

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
        mobileProfileScaffold: MobileProfileScaffold(
          name: 'John Doe',
          imageAssetPath: 'assets/images/profile.jpg',
          role: 'Developer',
          year: '2002',
          nucleos: 'Engineering',
        ),
        tabletProfileScaffold: TabletProfileScaffold(
          name: 'John Doe',
          imageAssetPath: 'assets/images/profile.jpg',
          role: 'Developer',
          year: '2002',
          nucleos: 'Engineering',
        ),
        desktopProfileScaffold: DesktopProfileScaffold(
          name: 'John Doe',
          imageAssetPath: 'assets/images/profile.jpg',
          role: 'Developer',
          year: '2002',
          nucleos: 'Engineering',
        ),
      ),
    );
  }
}
