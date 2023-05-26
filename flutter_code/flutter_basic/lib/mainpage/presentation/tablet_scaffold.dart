import 'package:flutter/material.dart';
import 'package:flutter_basic/constants.dart';

import '../hojeNaFct.dart';
import '../myAppBar.dart';
import '../weatherBox.dart';
import 'buildViews.dart';

class TabletScaffold extends StatefulWidget {
  const TabletScaffold({Key? key}) : super(key: key);

  @override
  State<TabletScaffold> createState() => _TabletScaffoldState();
}

class _TabletScaffoldState extends State<TabletScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      backgroundColor: myBackground,
      drawer: myDrawer,
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 4,
            child: SizedBox(
              width: double.infinity,
              child: GridView.builder(
                itemCount: 4,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                  itemBuilder: (context, index) {
                    return ViewUtil.buildItem(context, index);
                  }
              ),
            ),
          ),
          Expanded(
            child: ViewUtil.buildListView(),
          ),
        ],
      ),
    );
  }
}
