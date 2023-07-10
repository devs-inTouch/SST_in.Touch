import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basic/nucleos/application/nucleosAuth.dart';
import 'package:flutter_basic/nucleos/presentation/responsive_nucleos_page_SU.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../constants.dart';

class NucleosCriacaoPage extends StatefulWidget {
  const NucleosCriacaoPage({super.key});

  @override
  State<NucleosCriacaoPage> createState() => NucleosState();
}

class NucleosState extends State<NucleosCriacaoPage> {
  late XFile file;
  late Uint8List selectedImageInBytes;
  String selectFile = "";
  String mediaURL = "";
  String postId = Uuid().v4();

  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController faceUrl = TextEditingController();
  TextEditingController instaUrl = TextEditingController();
  TextEditingController twitterUrl = TextEditingController();

  bool isUploading = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> handleChoosePhoto() async {
    FilePickerResult? fileResult = await FilePicker.platform.pickFiles();

    if (fileResult != null) {
      setState(() {
        selectFile = fileResult.files.first.name!;
        selectedImageInBytes = fileResult.files.first.bytes!;
      });
    }
    print("Chegou aqui");
    print(selectFile);
  }

  handleSubmit() async {
    putInDatabase(
      title: title.text,
      description: description.text,
      faceUrl: faceUrl.text,
      instaUrl: instaUrl.text,
      twitterUrl: twitterUrl.text,
    );
    title.clear();
    description.clear();
    instaUrl.clear();
    twitterUrl.clear();
    faceUrl.clear();
  }

  void putInDatabase({
    required String title,
    required String description,
    required String faceUrl,
    required String instaUrl,
    required String twitterUrl,
  }) {
    print("title do nucleo" + title);

    NucleosAuth.makeNucleoRequest(
            title, description, faceUrl, instaUrl, twitterUrl)
        .then((value) {
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
                    child: Text("Núcleo criado"),
                  ),
                ],
              );
            });
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return SimpleDialog(
              title: const Center(
                child: Text('Erro'),
              ),
              children: const [
                Center(
                  child: Text("Tente Novamente"),
                ),
              ],
            );
          },
        );
      }
    });
  }

  Future<void> selectImage() async {
    await showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Imagem'),
          children: [
            SimpleDialogOption(
              child: const Text('Escolhe da galeria'),
              onPressed: () {
                handleChoosePhoto();
                Navigator.pop(context);
              },
            ),
            SimpleDialogOption(
              child: const Text('Cancelar'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
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
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    color: Colors.grey[300],
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            "CRIAÇÃO DE NÚCLEOS",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24.0,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ResponsiveNucleosPageSU()),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 20.0),
                    child: Container(
                      height: 600,
                      width: 1000,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent[200],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                                    height: 800,
                                    width: 800,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              15.0, 15.0, 15.0, 0.0),
                                          child: TextField(
                                            controller: title,
                                            maxLength: 30,
                                            decoration: const InputDecoration(
                                              fillColor: Colors.white,
                                              filled: true,
                                              labelText: 'Título',
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              15.0, 15.0, 15.0, 0.0),
                                          child: TextField(
                                            controller: description,
                                            keyboardType:
                                                TextInputType.multiline,
                                            maxLines: 4,
                                            maxLength: 130,
                                            decoration: const InputDecoration(
                                              fillColor: Colors.white,
                                              filled: true,
                                              labelText: 'Escreve aqui',
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              15.0, 15.0, 15.0, 0.0),
                                          child: TextField(
                                            controller: twitterUrl,
                                            decoration: const InputDecoration(
                                              fillColor: Colors.white,
                                              filled: true,
                                              labelText: 'Link para mais informações',
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              15.0, 15.0, 15.0, 0.0),
                                          child: TextField(
                                            controller: instaUrl,
                                            decoration: const InputDecoration(
                                              fillColor: Colors.white,
                                              filled: true,
                                              labelText: 'Instagram do Núcleo',
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              15.0, 15.0, 15.0, 0.0),
                                          child: TextField(
                                            controller: faceUrl,
                                            decoration: const InputDecoration(
                                              fillColor: Colors.white,
                                              filled: true,
                                              labelText: 'Facebook do Núcleo',
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
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Align(
                                    alignment: Alignment(-0.9, 0.9),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        // selectImage();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        fixedSize: const Size(150, 50),
                                        backgroundColor: Colors.blue[800],
                                      ),
                                      child: const Text(
                                        'Adicionar foto',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Align(
                                    alignment: Alignment(0.9, 0.9),
                                    child: ElevatedButton(
                                      onPressed: isUploading
                                          ? null
                                          : () => handleSubmit(),
                                      style: ElevatedButton.styleFrom(
                                        fixedSize: const Size(150, 50),
                                        backgroundColor: Colors.blue[800],
                                      ),
                                      child: const Text(
                                        'CRIAR',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      ),
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
