import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basic/anomalies/application/anomalyAuth.dart';
import 'package:uuid/uuid.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as Im;

import '../../constants.dart';
import 'anomalyBox.dart';
import '../../myAppBar.dart';

class AnomaliesPage extends StatefulWidget {
  const AnomaliesPage({super.key});

  State<AnomaliesPage> createState() => AnomalyState();
}

class AnomalyState extends State<AnomaliesPage> {
  List anomalyList = [];

  void initState() {
    super.initState();
    fetchAnomalies();
  }

  void fetchAnomalies() async {
    final response = await AnomalyAuth.getAnomaliesList();
    setState(() {
      anomalyList = response;
    });
    print("Anomalies fetched");
    print(anomalyList);
  }

  late File file;
  String postId = const Uuid().v4();
  final storageRef = FirebaseStorage.instance.ref();

  TextEditingController description = TextEditingController();
  TextEditingController title = TextEditingController();

  bool isUploading = false;

  /* void createButtonPressed(String username, String title, String description) {
    AnomalyAuth.listAnomaly().then((isCreated) {
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
  } */

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

  putInDatabase({required String title, required String description}) {
    print("title aqui" + title);

    AnomalyAuth.makeAnomalyRequest(title, description).then((value) {
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
                    child: Text("Anomalia criada"),
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
                    child: Text("Tente novamente"),
                  ),
                ],
              );
            });
      }
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
    putInDatabase(title: title.text, description: description.text);
    title.clear();
    description.clear();
  }
  /**
      selectImage(parentContext) {
      return showDialog(
      context: parentContext,
      builder: (context) {
      return SimpleDialog(
      title: const Text('Anexar Imagem'),
      children: [
      SimpleDialogOption(
      child: const Text('Escolhe da galeria'),
      onPressed: () {
      handleChoosePhoto(context);
      },
      ),
      SimpleDialogOption(
      child: const Text('Cancelar'),
      onPressed: () => Navigator.pop(context))
      ],
      );
      });
      }
   **/
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const MyAppBar(),
      backgroundColor: myBackground,
      body: Stack(
        children: [
          Container(
            width: size.width,
            height: size.height,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
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
                    padding:
                    const EdgeInsets.all(20.0), // Add a margin of 30 pixels
                    child: Container(
                      height: 400,
                      width: 1000,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent[200],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: Stack(
                              children: [
                                isUploading
                                    ? const LinearProgressIndicator()
                                    : const SizedBox(),
                                Align(
                                  alignment: const Alignment(0.0, 0.1),
                                  child: Container(
                                    height: 400,
                                    width: 800,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              15.0,
                                              15.0,
                                              15.0,
                                              0.0), // Add vertical padding of 15 pixels
                                          child: TextField(
                                            controller: title,
                                            maxLength: 50,
                                            decoration: const InputDecoration(
                                              fillColor: Colors.white,
                                              filled: true,
                                              labelText: 'Título',
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              15.0,
                                              15.0,
                                              15.0,
                                              0.0), // Add vertical padding of 15 pixels
                                          child: TextField(
                                            controller: description,
                                            keyboardType:
                                            TextInputType.multiline,
                                            maxLines: 7,
                                            maxLength: 400,
                                            decoration: const InputDecoration(
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
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                /**Padding(
                                    padding: const EdgeInsets.only(
                                    right:
                                    20.0), // Add right padding of 30 pixels
                                    child: ElevatedButton(
                                    onPressed: () {
                                    selectImage(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                    fixedSize: const Size(150, 40),
                                    backgroundColor: Colors.white,
                                    ),
                                    child: const Text(
                                    'Adicionar foto',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                                    ),
                                    ),
                                    ),
                                 **/
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left:
                                      20.0), // Add left padding of 30 pixels
                                  child: ElevatedButton(
                                    onPressed: isUploading
                                        ? null
                                        : () => handleSubmit(),
                                    style: ElevatedButton.styleFrom(
                                      fixedSize: const Size(100, 40),
                                      backgroundColor: Colors.white,
                                    ),
                                    child: const Text(
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
                  const SizedBox(height: 10),
                  Padding(
                    padding:
                    const EdgeInsets.all(20.0), // Add a margin of 30 pixels
                    child: Container(
                      width: 800,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: anomalyList.length,
                        itemBuilder: (BuildContext context, int index) {
                          AnomalyBox anomalyBox = anomalyList[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: AnomalyBox(
                              username: anomalyBox.username,
                              type: anomalyBox.type,
                              description: anomalyBox.description,
                            ),
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
	