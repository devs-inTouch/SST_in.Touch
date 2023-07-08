import 'package:flutter/cupertino.dart';
import 'package:flutter_basic/searchBarPage/presentation/searchBarMobile.dart';
import 'package:flutter_basic/searchBarPage/presentation/searchBarPage.dart';

class ResponsiveSearchPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if(constraints.maxWidth < 600){
        return SearchBarMobile();
      }else {
        return SearchBarPage();
      }
    },);
  }

}


