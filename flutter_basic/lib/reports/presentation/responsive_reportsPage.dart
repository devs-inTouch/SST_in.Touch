import 'package:flutter/cupertino.dart';
import 'package:flutter_basic/reports/presentation/reportsPage.dart';
import 'package:flutter_basic/reports/presentation/reportsPageMobile.dart';

class ResponsiveReportsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if(constraints.maxWidth < 600){
        return ReportsPageMobile();
      }else {
        return ReportsPage();
      }
    },);
  }

}
