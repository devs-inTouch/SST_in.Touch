/* import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basic/profile/presentation/desktop_profile_scaffold.dart';
import 'package:flutter_basic/profile/presentation/mobile_profile_scaffold.dart';
import 'package:flutter_basic/profile/presentation/responsive_profile.dart';
import 'package:flutter_basic/profile/presentation/tablet_profile_scaffold.dart';

import 'firebase_options.dart';
import 'mainpage/presentation/desktop_main_scaffold.dart';
import 'mainpage/presentation/mobile_main_scaffold.dart';
import 'mainpage/presentation/tablet_main_scaffold.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
 */
import 'package:flutter/material.dart';
import 'package:external_app_launcher/external_app_launcher.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Open External Apps'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              await LaunchApp.openApp(
                androidPackageName: 'com.tranzmate',
                openStore: true,
              );
            },
            child: const Text('Open External Apps'),
          ),
        ),
      ),
    );
  }
}
