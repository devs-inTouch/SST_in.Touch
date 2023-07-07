import 'package:flutter/material.dart';
import 'package:flutter_basic/backoffice/presentation/backOfficeMobilePage.dart';

import 'backOfficePage.dart';



class ResponsiveBackOffice extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if(constraints.maxWidth < 600){
        return BackOfficeMobile();
      }else {
        return BackOffice();
      }
    },);
  }

}
