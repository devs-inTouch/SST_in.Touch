import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../myAppBar.dart';
import '../application/noticiasAuth.dart';
import 'newsBox.dart';

class NewsPageMobile extends StatefulWidget {
  const NewsPageMobile({Key? key}) : super(key: key);

  @override
  State<NewsPageMobile> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPageMobile> {
  List<NewsBox> news = [];
  late PageController _pageController;
  DateTime currentDate = DateTime.now();
  List<Map<String, dynamic>> events = [];
  int _currentPageIndex = 0; // Track the current page index


  @override
  void initState() {
    super.initState();
    fetchData();
    _pageController = PageController(initialPage: _currentPageIndex);

  }

  Future<void> fetchData() async {
    final response = await NoticiasAuth.getNews();
    setState(() {
      news = response;
    });
    print("done this step noticias");
  }


  void nextPage() {
    setState(() {
      _currentPageIndex = (_currentPageIndex + 1) % news.length;
      _pageController.animateToPage(
        _currentPageIndex,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  void previousPage() {
    setState(() {
      _currentPageIndex = (_currentPageIndex - 1) % news.length;
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
    final fem = size.width / 1440; // 1440 is the reference width

    return Scaffold(
      backgroundColor: myBackground,
      body: Center(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Align children to the start
            children: [
              Container(
                height: 70,
                width: double.infinity, // Increase the height of the container
                decoration: mainMenuDecoration,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.newspaper,
                      color: Colors.white,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'NOTÍCIAS DA FACULDADE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20, // Increase the font size
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              child: Center(
                child: Container(
                  width: 500,
                  padding: const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 20.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 300, // Defina a altura desejada para cada notícia
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: news.length,
                          itemBuilder: (BuildContext context, int index) {
                            final post = news[index];
                            post.setFem(fem);
                            return post;
                          },
                          onPageChanged: (int index) {
                            setState(() {
                              _currentPageIndex = index;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 20),
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
              ),
            ),
          ),
            ],
          ),
        ),
      ),

    );
  }

}






