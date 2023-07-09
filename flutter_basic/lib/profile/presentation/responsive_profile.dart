import 'package:flutter/cupertino.dart';
import 'package:flutter_basic/nucleos/presentation/nucleosPage.dart';
import 'package:flutter_basic/nucleos/presentation/nucleosPageMobile.dart';
import 'package:flutter_basic/profile/presentation/profile_scaffold.dart';
import 'package:flutter_basic/profile/presentation/profile_scaffold_Mobile.dart';
import 'package:flutter_basic/reports/presentation/reportsPage.dart';
import 'package:flutter_basic/reports/presentation/reportsPageMobile.dart';

class ResponsiveProfile extends StatelessWidget {

  final Widget mobileProfileScaffold;
  final Widget profileScaffold;

  const ResponsiveProfile({super.key,
  required this.mobileProfileScaffold,
  required this.profileScaffold,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if(constraints.maxWidth < 600){
        return mobileProfileScaffold;
      }else {
        return profileScaffold;
      }
    },);
  }

}
