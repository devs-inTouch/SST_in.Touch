import 'package:flutter/material.dart';
import 'package:flutter_basic/constants.dart';
import 'package:flutter_basic/myAppBarMobile.dart';
import '../../bottomAppBarMobile.dart';
import '../../myAppBar.dart';

class SearchBarMobile extends StatelessWidget {

  String targetUsername = '';

  void checkUsername() {
    // Lógica para verificar se o nome de usuário existe no banco de dados
    // ...
  }
    // Se o nome de usuário existir, abrir o perfil correspondente
    // ...

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: MyAppBarMobile(),
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
                              child: TextField(
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (value) {
                                  targetUsername = value;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            checkUsername();
                          },
                          child: Text('Verificar perfil'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: MyBottomAppBar(),
      );
    }

  }




