import 'package:flutter/cupertino.dart';
import 'package:flutter_basic/anomalies/presentation/anomaliesPage.dart';
import 'package:flutter_basic/anomalies/presentation/anomaliesPageMobile.dart';
import 'package:flutter_basic/feeds/presentation/feedPage.dart';
import 'package:flutter_basic/feeds/presentation/feedPageMobile.dart';

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
