
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basic/myAppBar.dart';
import 'package:flutter_basic/myAppBarMobile.dart';
import 'package:flutter_basic/senhas/application/senhasRequests.dart';
import 'package:image_network/image_network.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../bottomAppBarMobile.dart';
import '../../mainpage/presentation/desktop_main_scaffold.dart';
import '../../mainpage/presentation/mobile_main_scaffold.dart';
import '../../mainpage/presentation/responsive_main_page.dart';
import '../../mainpage/presentation/tablet_main_scaffold.dart';

class MyQRCodePage extends StatefulWidget {

  @override
  _MyQRCodePageState createState() => _MyQRCodePageState();

}


class _MyQRCodePageState extends State<MyQRCodePage> {
  var uuid = Uuid();
  TextEditingController phoneNumber = TextEditingController();
  String CodeID = '';

  String? time;
  
  @override
  void initState() {
    getCode();
    super.initState();

  }

  Future<void> getCode() async {
    String code = await SenhasRequests.getPersonalCode();
    setState(() {
      CodeID = code;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBarMobile(),
      body: ListView(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ResponsiveLayout(
                      mobileScaffold: MobileScaffold(),
                      tabletScaffold: TabletScaffold(),
                      desktopScaffold: DesktopScaffold(),
                    ),
                  ),
                );
              },
            ),
          ),

          Center(
            child: Column(
              children: [
                
                    CodeID != '' ? Padding(padding:EdgeInsets.only(top:100),
                      child:  QrImageView(data: CodeID, size: 300,),
                    ):
                    Padding( padding: EdgeInsets.only(top:100),
                      child: Column(children: [
                        Icon(Icons.cancel, color: Colors.redAccent, size: 100,),
                        Text("Não existe código")
                      ],)),
                    Padding(padding: EdgeInsets.only(top:40),
                    child:Container(
                      width: 200,
                      child:TextField(
                      controller: phoneNumber,
                      decoration: InputDecoration(
                        labelText: "Numero de telefone"
                      ),
                    ),),),

                    Padding(padding: EdgeInsets.only(top: 50),
                     child:OutlinedButton(

                      onPressed: () async {
                        if(CodeID == '') {
                          String code = uuid.v4();
                          bool res = await SenhasRequests.createQRCode(code, phoneNumber.text);
                          if(res) {
                            setState(() {
                            CodeID=code;
                          });
                          }

                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Código já gerado'),
                                content: Icon(Icons.cancel,color: Colors.red,size: 100,),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('Ok'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }

                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        fixedSize:  Size(200, 75),
                      ),
                      child: Text("Pedir",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white
                      ),),

                    ))
                  ],
                )


          )
        ],
      ),
      bottomNavigationBar: MyBottomAppBar(),

    );
  }

}