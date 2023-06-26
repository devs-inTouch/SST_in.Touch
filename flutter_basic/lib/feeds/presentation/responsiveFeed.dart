
import 'package:flutter/material.dart';
import 'package:flutter_basic/feeds/presentation/feedPage.dart';

import 'feedPageMobile.dart';

class ResponsiveFeed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if(constraints.maxWidth<500){
        return FeedsPageMobile();
      }else {
        return FeedsPage();
      }
    },);
  }
  
}