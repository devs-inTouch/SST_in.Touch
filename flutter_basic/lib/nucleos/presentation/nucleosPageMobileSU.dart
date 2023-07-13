import 'package:flutter/material.dart';
import 'package:flutter_basic/nucleos/presentation/nucleosCriacaoPage.dart';
import '../../bottomAppBarMobile.dart';
import '../../constants.dart';
import '../../myAppBarMobile.dart';
import '../application/nucleosAuth.dart';
import 'nucleosBox.dart';

class NucleosPageMobileSU extends StatefulWidget {
  const NucleosPageMobileSU({super.key});

  State<NucleosPageMobileSU> createState() => NucleosState();
}

class NucleosState extends State<NucleosPageMobileSU> {
  List<NucleosBox> nucleosList = [];
  late PageController _pageController;
  int _currentPageIndex = 0;

  void initState() {
    _pageController = PageController(initialPage: _currentPageIndex);
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

  void nextPage() {
    setState(() {
      _currentPageIndex = (_currentPageIndex + 1) % nucleosList.length;
      _pageController.animateToPage(
        _currentPageIndex,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  void previousPage() {
    setState(() {
      _currentPageIndex = (_currentPageIndex - 1 + nucleosList.length) % nucleosList.length;
      _pageController.animateToPage(
        _currentPageIndex,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fem = size.width / 1440;

    return Scaffold(
      appBar: const MyAppBarMobile(),
      backgroundColor: myBackground,
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 10),
            Text(
              "LISTA DE NÚCLEOS",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 35,
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Container(
                    height: 500,
                    child: PageView.builder(
                      controller: _pageController,
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
                      onPageChanged: (int index) {
                        setState(() {
                          _currentPageIndex = index;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: previousPage,
                        icon: Icon(Icons.arrow_back),
                      ),
                      IconButton(
                        onPressed: nextPage,
                        icon: Icon(Icons.arrow_forward),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),

      ),
      bottomNavigationBar: MyBottomAppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NucleosCriacaoPage(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

}
