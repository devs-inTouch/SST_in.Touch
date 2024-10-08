import 'dart:async';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basic/constants.dart';
import 'package:flutter_basic/feeds/application/postRequests.dart';
import 'package:flutter_basic/feeds/presentation/postBox.dart';
import 'package:uuid/uuid.dart';
import 'package:image_picker/image_picker.dart';

import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';
import '../../myAppBar.dart';

class FeedsPage extends StatefulWidget {
  State<FeedsPage> createState() => FeedState();
}

class FeedState extends State<FeedsPage> {
  List<PostBox> _posts = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await PostRequests.getFeed();
    setState(() {
      _posts = response;
    });
    print("done this step");
  }

  late XFile file;
  late Uint8List selectedImageInBytes;
  String selectFile = "";
  String mediaURL = "";
  String postId = Uuid().v4();

  TextEditingController description = TextEditingController();
  bool isUploading = false;
  bool imageUploaded = false;

  bool isButtonDisabled = false;

  void disableButton() {
    setState(() {
      isButtonDisabled = true;
    });

    Timer(Duration(seconds: 10), () {
      setState(() {
        isButtonDisabled = false;
      });
    });
  }

  handleChoosePhoto(context) async {
    print("1");
    FilePickerResult? fileResult = await FilePicker.platform.pickFiles();

    if (fileResult != null) {
      setState(() {
        selectFile = fileResult.files.first.name;
        selectedImageInBytes = fileResult.files.first.bytes!;
      });
    }
    Navigator.pop(context);

  }

  Future<String> uploadFile() async {


    UploadTask uploadTask;
    Reference storageRef =
    fireBaseStorageInstance.ref().child("/posts/" + postId);

    final metadata = SettableMetadata(contentType: 'image/jpeg');
    uploadTask = storageRef.putData(selectedImageInBytes, metadata);


    await uploadTask.whenComplete(() => null);
    String imageUrl = "";
    imageUrl = await storageRef.getDownloadURL();
    return imageUrl;

  }



  putInDatabase({required String mediaUrl, required String desc}) {
    print("Media aqui" + mediaUrl);
    PostRequests.makePostRequest(mediaUrl, desc).then((value) {
      if (value == true) {
        showDialog(
            context: context,
            builder: (context) {
              return SimpleDialog(
                title: Center(
                  child: Text('Sucesso'),
                ),
                children: [
                  Center(
                    child: Text("Publicação criada"),
                  ),
                ],
              );
            });
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return SimpleDialog(
                title: Center(
                  child: Text('Erro'),
                ),
                children: [
                  Center(
                    child: Text("Tente Novamente"),
                  ),
                ],
              );
            });
      }
    });
  }



  handleSubmit() async {
    setState(() {
      isUploading = true;
    });
    String image = await uploadFile();
    if(image != '') {
      setState(() {
        imageUploaded = true;
      });
    }
    print(image);
    print("aqui");
    putInDatabase(mediaUrl: image, desc: description.text);
    print("Ali");
    description.clear();
    print("Image uploaded");
    disableButton();
    setState(() {
      isUploading = false;
    });
  }

  selectImage(parentContext) {
    return showDialog(
        context: parentContext,
        builder: (context) {
          return SimpleDialog(
            title: Text('Imagem'),
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
    final fem = size.width / 1440;
    return Scaffold(
      appBar: MyAppBar(),
      backgroundColor: myBackground,
      body: Stack(
        children: [
          Container(
            width: size.width,
            height: size.height,
            child: Scrollbar(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        'FEED',
                        textAlign: TextAlign.center,
                        style:TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 45),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: Container(
                        height: 400,
                        width: 500,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent[200],
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Stack(
                          children: [
                            isUploading ? LinearProgressIndicator() : Text(""),
                            Align(
                              alignment: Alignment(0.0, -0.4),
                              child: Container(
                                height: 300,
                                width: 470,
                                child: Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child: TextField(
                                    controller: description,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 10,
                                    maxLength: 400,
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      filled: true,
                                      labelText: 'Escrever aqui',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment(0.9, 0.9),
                              child: ElevatedButton(
                                onPressed:
                                isUploading && isButtonDisabled ? null : () => handleSubmit(),
                                style: ElevatedButton.styleFrom(
                                  fixedSize: Size(120, 40),
                                  backgroundColor: Colors.blue[800],
                                ),
                                child: Text(
                                  'CRIAR',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment(-0.9, 0.9),
                              child: ElevatedButton(
                                onPressed: () {
                                  selectImage(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  fixedSize: Size(150, 50),
                                  backgroundColor: Colors.blue[800],
                                ),
                                child: Text(
                                  'Adicionar foto',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ),
                            ),
                            imageUploaded ? Align(
                                alignment:Alignment(-0.8,0.9),
                                child: Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                )
                            ) : Container(),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: 500,
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: _posts.length,
                          itemBuilder: (BuildContext context, int index) {
                            final post = _posts[index];
                            post.setFem(fem);
                            return post;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
