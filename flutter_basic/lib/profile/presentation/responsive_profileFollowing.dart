import 'package:flutter/cupertino.dart';
import 'package:flutter_basic/nucleos/presentation/nucleosPage.dart';
import 'package:flutter_basic/nucleos/presentation/nucleosPageMobile.dart';
import 'package:flutter_basic/profile/presentation/profileFollowing_scaffold.dart';
import 'package:flutter_basic/profile/presentation/profileFollowing_scaffold_Mobile.dart';
import 'package:flutter_basic/reports/presentation/reportsPage.dart';
import 'package:flutter_basic/reports/presentation/reportsPageMobile.dart';

class ResponsiveProfileFollowing extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if(constraints.maxWidth < 600){
        return ThirdPartyProfileScaffoldMobile(
          name: 'John Doe',
          imageAssetPath: 'assets/images/profile.jpg',
          role: 'Developer',
          year: '2002',
          nucleos: 'Engineering',
        );
      }else {
        return ThirdPartyProfileScaffold(
          name: 'John Doe',
          imageAssetPath: 'assets/images/profile.jpg',
          role: 'Developer',
          year: '2002',
          nucleos: 'Engineering',
        );
      }
    },);
  }

}
