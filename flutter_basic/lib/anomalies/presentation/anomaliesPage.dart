import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basic/anomalies/application/anomalyAuth.dart';
import 'package:uuid/uuid.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as Im;

import '../../constants.dart';
import '../../feeds/anomalyBox.dart';
import '../../mainpage/presentation/desktop_main_scaffold.dart';
import '../../mainpage/presentation/mobile_main_scaffold.dart';
import '../../mainpage/presentation/responsive_main_page.dart';
import '../../mainpage/presentation/tablet_main_scaffold.dart';
import '../../myAppBar.dart';
import '../../profile/presentation/viewUtils.dart';

class AnomaliesPage extends StatefulWidget {
  State<AnomaliesPage> createState() => AnomalyState();
}

class AnomalyState extends State<AnomaliesPage> {
  List anomalyPosts = ["post 1", "post 2", "post 3", "post 4"];

  late File file;
  String postId = Uuid().v4();
  final storageRef = FirebaseStorage.instance.ref();

  TextEditingController description = TextEditingController();
  TextEditingController title = TextEditingController();

  bool isUploading = false;

  void createButtonPressed(String username, String title, String description) {
    AnomalyAuth.listAnomaly(username, title, description).then((isCreated) {
      if (isCreated) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ResponsiveLayout(
                    desktopScaffold: DesktopScaffold(),
                    mobileScaffold: MobileScaffold(),
                    tabletScaffold: TabletScaffold())));
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Parametros incorretos'),
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
    });
  }

  handleTakePhoto(context) async {
    Navigator.pop(context);
    File file = (await ImagePicker().pickImage(
        source: ImageSource.camera, maxHeight: 675, maxWidth: 960)) as File;
    setState(() {
      this.file = file;
    });
  }

  handleChoosePhoto(context) async {
    Navigator.pop(context);
    File file = (await ImagePicker().pickImage(
        source: ImageSource.gallery, maxHeight: 675, maxWidth: 960)) as File;
    setState(() {
      this.file = file;
    });
  }

  Future<String> uploadImage(image) async {
    UploadTask task = storageRef.child("post_$postId.jpg").putFile(image);
    TaskSnapshot storage = await task;
    String downloadUrl = await storage.ref.getDownloadURL();
    return downloadUrl;
  }

  putInDatabase(
      {required String mediaUrl, required String title, required String desc}) {
    // fazer pedido REST
  }

  submitPost() async {
    await compressImage();
    String url = await uploadImage(file);
    putInDatabase(mediaUrl: url, title: title.text, desc: description.text);
    description.clear();
    setState(() {
      isUploading = false;
    });
  }

  compressImage() async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    Im.Image? image = Im.decodeImage(file.readAsBytesSync());
    final compressedImage = File('$path/img_$postId.jpg')
      ..writeAsBytesSync(Im.encodeJpg(image!, quality: 85));
    setState(() {
      file = compressedImage;
    });
  }

  handleSubmit() async {
    setState(() {
      isUploading = true;
    });
    await compressImage();
    String mediaUrl = await uploadImage(file);
    putInDatabase(
        mediaUrl: mediaUrl, title: title.text, desc: description.text);
    description.clear();
    setState(() {
      isUploading = false;
    });
  }

  selectImage(parentContext) {
    return showDialog(
        context: parentContext,
        builder: (context) {
          return SimpleDialog(
            title: Text('Anexar Imagem'),
            children: [
              SimpleDialogOption(
                child: Text('Escolhe da galeria'),
                onPressed: () {
                  handleChoosePhoto(context);
                },
              ),
              SimpleDialogOption(
                  child: Text('Cancelar'),
                  onPressed: () => Navigator.pop(context))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: MyAppBar(),
      drawer: myDrawer,
      backgroundColor: Colors.grey[300],
      body: Stack(
        children: [
          Container(
            width: size.width,
            height: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Text(
                      'ANOMALIAS',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 26),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(30.0), // Add a margin of 30 pixels
                    child: Container(
                      height: 400,
                      width: 800,
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: Stack(
                              children: [
                                isUploading
                                    ? LinearProgressIndicator()
                                    : SizedBox(),
                                Align(
                                  alignment: Alignment(0.0, 0.1),
                                  child: Container(
                                    height: 400,
                                    width: 800,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(
                                              15.0), // Add vertical padding of 15 pixels
                                          child: TextField(
                                            controller: title,
                                            maxLength: 50,
                                            decoration: InputDecoration(
                                              fillColor: Colors.white,
                                              filled: true,
                                              labelText: 'Título',
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(
                                              15.0), // Add vertical padding of 15 pixels
                                          child: TextField(
                                            controller: description,
                                            keyboardType:
                                                TextInputType.multiline,
                                            maxLines: 7,
                                            maxLength: 400,
                                            decoration: InputDecoration(
                                              fillColor: Colors.white,
                                              filled: true,
                                              labelText: 'Escreve aqui',
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      right:
                                          30.0), // Add right padding of 30 pixels
                                  child: ElevatedButton(
                                    onPressed: () {
                                      selectImage(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      fixedSize: Size(150, 40),
                                      backgroundColor: Colors.white,
                                    ),
                                    child: Text(
                                      'Adicionar foto',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 15),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left:
                                          30.0), // Add left padding of 30 pixels
                                  child: ElevatedButton(
                                    onPressed: isUploading
                                        ? null
                                        : () => createButtonPressed("gui",
                                            title.text, description.text),
                                    style: ElevatedButton.styleFrom(
                                      fixedSize: Size(100, 40),
                                      backgroundColor: Colors.white,
                                    ),
                                    child: Text(
                                      'CRIAR',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 15),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.all(20.0), // Add a margin of 30 pixels
                    child: Container(
                      width: 800,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: anomalyPosts.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    10.0), // Add bottom padding of 10 pixels
                            child: AnomalyBox(text: anomalyPosts[index]),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
