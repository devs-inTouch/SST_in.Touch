import 'package:flutter/cupertino.dart';
import 'package:flutter_basic/anomalies/presentation/anomaliesPage.dart';
import 'package:flutter_basic/anomalies/presentation/anomaliesPageMobile.dart';

class ResponsiveAnomalyPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if(constraints.maxWidth < 600){
        return AnomaliesPageMobile();
      }else {
        return AnomaliesPage();
      }
    },);
  }

}
