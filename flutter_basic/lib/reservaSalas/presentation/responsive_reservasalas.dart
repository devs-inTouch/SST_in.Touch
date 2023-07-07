import 'package:flutter/cupertino.dart';
import 'package:flutter_basic/reservaSalas/presentation/desktop_reservasalas_page.dart';
import 'package:flutter_basic/reservaSalas/presentation/tablet_reservasalas_page.dart';

class ResponsiveReservaSalas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if(constraints.maxWidth < 600){
        return ReservaSalasPageMobile();
      }else {
        return ReservaSalasPage();
      }
    },);
  }

}