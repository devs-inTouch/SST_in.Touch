import 'package:flutter/cupertino.dart';
import 'package:flutter_basic/nucleos/presentation/nucleosPage.dart';
import 'package:flutter_basic/nucleos/presentation/nucleosPageMobile.dart';

import 'nucleosPageMobileSU.dart';
import 'nucleosPageSU.dart';

class ResponsiveNucleosPageSU extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if(constraints.maxWidth < 600){
        return NucleosPageMobileSU();
      }else {
        return NucleosPageSU();
      }
    },);
  }

}
