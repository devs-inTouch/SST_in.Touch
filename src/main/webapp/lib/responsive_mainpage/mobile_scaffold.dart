import 'package:flutter/material.dart';
import 'package:flutter_basic/constants.dart';
import 'package:flutter_basic/utils/my_box.dart';
import 'package:flutter_basic/utils/my_tile.dart';
class MobileScaffold extends StatefulWidget{
  const MobileScaffold ({Key? key}) : super (key: key);

  @override
  State<MobileScaffold> createState() => _MobileScaffoldState();
}

  class _MobileScaffoldState extends State<MobileScaffold>{
  @override
    Widget build(BuildContext context){
    return Scaffold(
      appBar: myAppBar,
      backgroundColor: myBackground,
      drawer: myDrawer,
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: SizedBox(
              width: double.infinity,
              child:GridView.builder(
                itemCount: 4,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
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