import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'backoffice/presentation/backOfficePage.dart';
import 'firebase_options.dart';
import 'login/presentation/loginPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
