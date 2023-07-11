

import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basic/myAppBar.dart';
import 'package:flutter_basic/myAppBarMobile.dart';
import 'package:flutter_basic/senhas/application/senhasRequests.dart';
import 'package:image_network/image_network.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:uuid/uuid.dart';

class ManagingSenhas extends StatefulWidget {
  @override
  ManagingSenhasState createState() => ManagingSenhasState();

}

class ManagingSenhasState extends State<ManagingSenhas> {

  String lidos = '';
  String resto = '';

  @override
  void initState() {
   getLidos();
   getResto();
    super.initState();
  }

  Future<void> getLidos() async {
    String res = await SenhasRequests.getLido();
    setState(() {
      lidos = res;
    });
  }

  Future<void> getResto() async {
    String res = await SenhasRequests.getResto();
    setState(() {
      resto = res;
    });
  }

  Future<void> refreshData() async {
    await getLidos();
    await getResto();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBarMobile(),
      body: RefreshIndicator(
        onRefresh: refreshData,
        child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child:Center(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 50),
            child:Text("Gestor de Senhas",
            style: TextStyle(
              fontSize: 40
            ),)
          ),
            Padding(padding: EdgeInsets.only(top: 70),
                child:Text("Senhas restantes:",
                  style: TextStyle(
                      fontSize: 30
                  ),)
            ),
            Padding(padding: EdgeInsets.only(top: 20),
                child:Text(resto,
                  style: TextStyle(
                      fontSize: 25
                  ),)
            ),
            Padding(padding: EdgeInsets.only(top: 70),
                child:Text("Senhas lidas:",
                  style: TextStyle(
                      fontSize: 30
                  ),)
            ),
            Padding(padding: EdgeInsets.only(top: 20),
                child:Text(lidos,
                  style: TextStyle(
                      fontSize: 25
                  ),)
            ),
        Padding(padding: EdgeInsets.only(top: 70),
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              fixedSize: Size(200, 100),
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MyQRCodePageScanner(),
              ));
            },
            child: const Text('Scanner',
            style: TextStyle(
              fontSize: 30,
              color: Colors.white
            ),),
          ),)
    ]),)))
    );
  }
  
}

class MyQRCodePageScanner extends StatefulWidget {

  @override
  _MyQRCodeScanner createState() => _MyQRCodeScanner();

}


class _MyQRCodeScanner extends State<MyQRCodePageScanner> {
  Barcode? barcode;
  final qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  bool isDialogOpen = false;

  @override
  void dispose() {
   controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    super.reassemble();

    if(Platform.isAndroid) {
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }


  void onQrViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
      controller.scannedDataStream.listen((barcode) async {
        setState(() {
          this.barcode = barcode;
        });
        if(this.barcode != null && !isDialogOpen) {
          isDialogOpen = true;
          bool res = await  SenhasRequests.checkSenha(barcode.code ?? "", "0");
          if(res) {
            showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Leitura correta'),
              content: Icon(Icons.check_circle,color: Colors.green,size: 100,),
              actions: <Widget>[
                TextButton(
                  child: const Text('Ok'),
                  onPressed: () {
                    isDialogOpen = false;
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
          } else {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Leitura incorreta'),
                  content: Icon(Icons.cancel,color: Colors.red,size: 100,),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Ok'),
                      onPressed: () {
                        isDialogOpen = false;
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          }
        }
      });
    });
  }

  Widget buildResult() => Text(barcode != null ?'Result : ${barcode!.code}' :"Scan a code!", maxLines: 3,);

  Widget buildQRView(BuildContext context) => QRView(key: qrKey, onQRViewCreated: onQrViewCreated
      ,overlay: QrScannerOverlayShape(
          borderWidth: 10,
          borderRadius: 10,
          cutOutSize: MediaQuery.of(context).size.width*0.8
      ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Stack(
        alignment: Alignment.center,
        children: [
          buildQRView(context),
          Positioned(bottom: 10,child: buildResult())
        ],
      )
    );


  }

}