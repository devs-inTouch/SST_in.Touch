
import 'package:flutter/cupertino.dart';
import 'package:flutter_basic/noticias/presentation/newsPage.dart';

import 'newsPageMobile.dart';

class ResponsiveNewsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if(constraints.maxWidth < 600){
        return NewsPageMobile();
      }else {
        return NewsPage();
      }
    },);
  }

}