import 'package:flutter/cupertino.dart';
import 'package:flutter_basic/maps/lib/mapMobile.dart';

import 'map.dart';

class ResponsiveMap extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if(constraints.maxWidth < 600){
        return GMapMobile();
      }else {
        return GMap();
      }
    },);
  }

}
