import 'package:flutter/material.dart';
import 'package:flutter_basic/constants.dart';
import 'package:flutter_basic/utils/my_box.dart';
import 'package:flutter_basic/utils/my_tile.dart';
class TabletScaffold extends StatefulWidget{
  const TabletScaffold ({Key? key}) : super (key: key);

  @override
  State<TabletScaffold> createState() => _TabletScaffoldState();
}

class _TabletScaffoldState extends State<TabletScaffold>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
    appBar: myAppBar,
    backgroundColor: myBackground,
    drawer: myDrawer,
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 4,
            child: SizedBox(
              width: double.infinity,
              child:GridView.builder(
                itemCount: 4,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (context, index){
                  return const MyBox();
                },
              ),
            ),
          ),
          Expanded(child: ListView.builder(itemCount: 3, itemBuilder: (context,index){
            return const MyTile();
          },
          ),
          )
        ],
      ),
    );
  }
}