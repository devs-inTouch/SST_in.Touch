import 'dart:io';


import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as Im;

import '../../constants.dart';
import '../../feeds/anomalyBox.dart';
import '../../myAppBar.dart';

class AnomaliesPage extends StatefulWidget {

    State<AnomaliesPage> createState() => AnomalyState();
}

class AnomalyState extends State<AnomaliesPage> {

  List anomalyPosts = [
    "post 1","post 2", "post 3", "post 4"
  ];

  late File file;
  String postId = Uuid().v4();
  final  storageRef = FirebaseStorage.instance.ref();

  TextEditingController description = TextEditingController();
  TextEditingController title = TextEditingController();

  bool isUploading = false;


  handleTakePhoto(context) async {
    Navigator.pop(context);
    File file = (await ImagePicker().pickImage(source: ImageSource.camera,
        maxHeight: 675, maxWidth: 960)) as File;
    setState(() {
      this.file = file;
    });
  }

  handleChoosePhoto(context) async{
    Navigator.pop(context);
    File file = (await ImagePicker().pickImage(source: ImageSource.gallery,
        maxHeight: 675, maxWidth: 960)) as File;
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

  putInDatabase({required String mediaUrl, required String title, required String desc}) {
    // fazer pedido REST
  }

  submitPost() async {
    await compressImage();
    String url = await uploadImage(file);
    putInDatabase(
        mediaUrl: url,
        title: title.text,
        desc: description.text
    );
    description.clear();
    setState(() {
      isUploading = false;
    });
  }

  compressImage() async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    Im.Image? image = Im.decodeImage(file.readAsBytesSync());
    final compressedImage = File('$path/img_$postId.jpg')..writeAsBytesSync(Im.encodeJpg(image!, quality: 85));
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
    putInDatabase(mediaUrl: mediaUrl, title: title.text, desc: description.text);
    description.clear();
    setState(() {
      isUploading = false;
    });
  }



  selectImage(parentContext) {
    return showDialog(context: parentContext,
        builder: (context) {
          return SimpleDialog(
            title: Text('Imagem'),
            children: [
              SimpleDialogOption(
                child: Text('Escolhe da galeria'),
                onPressed: () {handleChoosePhoto(context);},
              ),
              SimpleDialogOption(
                  child: Text('Cancelar'),
                  onPressed: () => Navigator.pop(context)

              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fem = size.width / 1440; // 1440 is the reference width

    return Scaffold(
      appBar: MyAppBar(),
      drawer: myDrawer,
      backgroundColor: myBackground,
      body: Stack(
        children: [
          Container(

            width: size.width,
            height: size.height,
            child:Scrollbar(
              child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text(
                              'ANOMALY',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 60

                              ),
                            )),
                        Container(
                            height: 500*fem,
                            width: 600*fem,
                            decoration: BoxDecoration(
                                color: Colors.grey[300]
                            ),
                            child: Stack(
                              children: [
                                isUploading ? LinearProgressIndicator() : Text(""),
                                Align(
                                  alignment: Alignment(0.0, 0.1),
                                  child: Container(
                                    height: 400 * fem,
                                    width: 570 * fem,
                                    child: Column(
                                      children: [
                                        TextField(
                                          controller: title,
                                          maxLength: 50,
                                          decoration: InputDecoration(
                                            fillColor: Colors.white,
                                            filled: true,
                                            labelText: 'Título',
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        TextField(
                                          controller: description,
                                          keyboardType: TextInputType.multiline,
                                          maxLines: 5,
                                          maxLength: 400,
                                          decoration: InputDecoration(
                                            fillColor: Colors.white,
                                            filled: true,
                                            labelText: 'Escreve aqui',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                Align( //Botao para adicionar foto
                                    alignment: Alignment(0.9,0.9),
                                    child:
                                    ElevatedButton(
                                        onPressed: isUploading ? null : () =>  handleSubmit(),
                                        style: ElevatedButton.styleFrom(
                                            fixedSize: Size(70* fem, 40* fem),
                                            backgroundColor: Colors.white
                                        ),
                                        child: Text(
                                          'CRIAR',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12

                                          ),

                                        )

                                    )),
                                Align( //Botao para adicionar foto
                                    alignment: Alignment(-0.9,0.9),
                                    child:
                                    ElevatedButton(
                                        onPressed: () { selectImage(context);},
                                        style: ElevatedButton.styleFrom(
                                            fixedSize: Size(100* fem, 40* fem),
                                            backgroundColor: Colors.white
                                        ),
                                        child: Text(
                                          'Adicionar foto',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15

                                          ),

                                        )

                                    ))
                              ],
                            )
                        ),
                        SizedBox(height: 10),
                        Container(
                            width: 600*fem,
                            child:ListView.builder(
                              shrinkWrap: true,
                              itemCount: anomalyPosts.length,
                              itemBuilder: (BuildContext context, int index) {
                                return AnomalyBox(text:anomalyPosts[index], fem: fem);
                              },

                            )
                        )
                      ]
                  )


              ),
            ),

          )
        ],
      ),
    );
  }


}