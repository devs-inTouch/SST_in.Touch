import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
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

/*
  handleTakePhoto(context) async {
    Navigator.pop(context);
    File file = (await ImagePicker().pickImage(source: ImageSource.camera,
        maxHeight: 675, maxWidth: 960)) as File;
    setState(() {
      this.file = file;
    });
  }*/

  handleChoosePhoto(context) async {
    print("1");
    FilePickerResult? fileResult = await FilePicker.platform.pickFiles();

    if (fileResult != null) {
      setState(() {
        selectFile = fileResult.files.first.name;
        selectedImageInBytes = fileResult.files.first.bytes!;
      });
    }
    print("Chegou aqui");
    print(selectFile);
  }

  uploadFile() async {
    setState(() {
      isUploading = true;
    });
    print("1");
    UploadTask uploadTask;
    Reference storageRef =
        FirebaseStorage.instance.ref().child("/" + selectFile);

    final metadata = SettableMetadata(contentType: 'image/jpeg');
    uploadTask = storageRef.putData(selectedImageInBytes, metadata);
    print("1");
    await uploadTask.whenComplete(() => null);
    String imageUrl = await storageRef.getDownloadURL();
    if (imageUrl != "") {
      setState(() {
        mediaURL = imageUrl;
      });
    }
    print("Image uploaded");
    print(mediaURL);
    setState(() {
      isUploading = false;
    });
  }

  /*
  Future<String> uploadImage(filename, blob) async {
      UploadTask task = storageRef.child("post_$postId.jpg").putFile(filename);
      TaskSnapshot storage = await task;
      String downloadUrl = await storage.ref.getDownloadURL();
      return downloadUrl;
  }*/

  putInDatabase({required String mediaUrl, required String desc}) {
    print("Media aqui" + mediaUrl);
    PostRequests.makePostRequest(mediaUrl, desc).then((value) {
      if (value == true) {
        showDialog(
            context: context,
            builder: (context) {
              return SimpleDialog(
                title: Text('Sucesso'),
                children: [Text("Publicação criada")],
              );
            });
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return SimpleDialog(
                title: Text('Erro'),
                children: [Text("Tente novamente")],
              );
            });
      }
    });
  }

  compressImage() async {
    /*
    final tempDir = Directory.systemTemp;
    final path = tempDir.path;
    Im.Image? image = Im.decodeImage(file.readAsBytesSync());
    final compressedImage = File('$path/img_$postId.jpg')..writeAsBytesSync(Im.encodeJpg(image!, quality: 85));
    setState(() {
      file = compressedImage;
    });*/
  }

  handleSubmit() async {
    uploadFile();
    print("aqui");
    putInDatabase(mediaUrl: mediaURL, desc: description.text);
    print("Ali");
    description.clear();
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
    final fem = size.width / 1440; // 1440 is the reference width

    return Scaffold(
      appBar: MyAppBar(),
      backgroundColor: Colors.grey[300],
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
                        style: TextStyle(color: Colors.black, fontSize: 60),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: Container(
                        height: 400,
                        width: 500,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(217, 217, 217, 1),
                        ),
                        child: Stack(
                          children: [
                            isUploading ? LinearProgressIndicator() : Text(""),
                            Align(
                              alignment: Alignment(0.0, -0.4),
                              child: Container(
                                height: 200,
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
                                    isUploading ? null : () => handleSubmit(),
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
