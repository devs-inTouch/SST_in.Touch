import 'package:flutter/material.dart';
import 'package:flutter_basic/nucleos/presentation/nucleosCriacaoPage.dart';
import '../../bottomAppBarMobile.dart';
import '../../constants.dart';
import '../../myAppBarMobile.dart';
import '../application/nucleosAuth.dart';
import 'nucleosBox.dart';

class NucleosPageMobile extends StatefulWidget {
  const NucleosPageMobile({super.key});

  State<NucleosPageMobile> createState() => NucleosState();
}

class NucleosState extends State<NucleosPageMobile> {
  List nucleosList = [];

  void initState() {
    super.initState();
    fetchNucleos();
  }

  void fetchNucleos() async {
    final response = await NucleosAuth.getNucleosList();
    setState(() {
      nucleosList = response;
    });
    print("nucleos fetched");
    print(nucleosList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBarMobile(),
      backgroundColor: myBackground,
      body: Center(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Scrollbar(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Text(
                    "LISTA DE NÚCLEOS",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 35),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: nucleosList.length,
                      itemBuilder: (BuildContext context, int index) {
                        NucleosBox nucleosBox = nucleosList[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: NucleosBox(
                            title: nucleosBox.title,
                            description: nucleosBox.description,
                            faceUrl: nucleosBox.faceUrl,
                            instaUrl: nucleosBox.instaUrl,
                            twitterUrl: nucleosBox.twitterUrl,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: MyBottomAppBar(),
    );
  }
}
