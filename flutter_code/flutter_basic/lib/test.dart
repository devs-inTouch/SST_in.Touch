import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'MoovitWidget.dart';

class Teste extends StatelessWidget {
  const Teste({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moovit Widget Example',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Moovit Widget Example'),
        ),
        body: Center(
          child: MoovitWidget(),
        ),
      ),
    );
  }
}
