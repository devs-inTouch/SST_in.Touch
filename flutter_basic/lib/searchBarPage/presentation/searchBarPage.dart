import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../myAppBar.dart';
import '../../profile/application/profleRequests.dart';
import '../../profile/presentation/profile_scaffold.dart';

class SearchBarPage extends StatefulWidget {

  @override
  _SearchBarState createState() => _SearchBarState();

}

class _SearchBarState extends State<SearchBarPage> {

  final TextEditingController searchValue = TextEditingController();
  List received = [];

  handleSearch() async{
    List searchResults = await ProfileRequests.getSearch(searchValue.text);

    setState(() {
      if(mounted) {
        received = searchResults;
      }
    });
    print("ola");

    return ListView.builder(
        itemCount: received.length,
        itemBuilder: (BuildContext context, int index) {
          final suggestion = received[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.orange,
              //backgroundImage: CachedNetworkImageProvider(''),
            ),
            title: Text(suggestion),

          );
        }
    );


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      backgroundColor: myBackground,
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'PESQUISAR POR PERFIL',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 5),
                Icon(
                  Icons.search,
                  size: 26,
                  color: Colors.black,
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blueAccent[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 7,
                            child: Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: EdgeInsetsDirectional.zero,
                                child: Text(
                                  'NOME DE UTILIZADOR',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            flex: 16,
                            child:  TextFormField(
                              controller: searchValue,
                              decoration: InputDecoration(
                                hintText: "Pesquisa utilizadores",
                                filled: true,
                                prefixIcon: Icon(Icons.account_box),
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.search),
                                  onPressed: handleSearch,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          handleSearch();
                        },
                        child: Text('Verificar perfil'),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top:10),

                      ), if(received.isNotEmpty)
                        SearchResultsWidget(searchResults: received)
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class SearchResultsWidget extends StatelessWidget {
  final List searchResults;

  const SearchResultsWidget({Key? key, required this.searchResults})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: searchResults.length,
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(height: 8);
      },
      itemBuilder: (BuildContext context, int index) {
        final suggestion = searchResults[index];
        return Container(
          color: Colors.white54,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.white,
              //backgroundImage: CachedNetworkImageProvider(''),
            ),
            title: Text(suggestion),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScaffold(
                    name: suggestion.toString(),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

}




