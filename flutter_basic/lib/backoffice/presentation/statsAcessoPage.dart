import 'package:flutter/material.dart';
import 'package:flutter_basic/backoffice/presentation/backOfficePage.dart';

import '../../constants.dart';
import '../../myAppBar.dart';

class StatsAcessoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      backgroundColor: myBackground,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "ESTATÍSTICA E CONTROLO DE ACESSOS",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BackOffice()),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 25.0),
            Container(
              width: 800,
              height: 500,
              padding: EdgeInsets.all(16.0),
              color: Colors.lightBlueAccent, // Cor de fundo do container
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    color: Colors.white, // Cor de fundo da primeira linha
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Users online:",
                          style: TextStyle(fontSize: 18.0),
                        ),
                        Container(
                          width: 100.0,
                          height: 40.0,
                          color: Colors.blue, // Cor de fundo do valor
                          child: Center(
                            child: Text(
                              "123",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    color: Colors.grey, // Cor de fundo da segunda linha
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Posts realizados:",
                          style: TextStyle(fontSize: 18.0),
                        ),
                        Container(
                          width: 100.0,
                          height: 40.0,
                          color: Colors.blue, // Cor de fundo do valor
                          child: Center(
                            child: Text(
                              "456",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    color: Colors.green, // Cor de fundo da terceira linha
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Reports por rever:",
                          style: TextStyle(fontSize: 18.0),
                        ),
                        Container(
                          width: 100.0,
                          height: 40.0,
                          color: Colors.blue, // Cor de fundo do valor
                          child: Center(
                            child: Text(
                              "789",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    color: Colors.orange, // Cor de fundo da quarta linha
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Contas por Ativar:",
                          style: TextStyle(fontSize: 18.0),
                        ),
                        Container(
                          width: 100.0,
                          height: 40.0,
                          color: Colors.blue, // Cor de fundo do valor
                          child: Center(
                            child: Text(
                              "321",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    color: Colors.purple, // Cor de fundo da quinta linha
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Pedidos de reserva por Rever:",
                          style: TextStyle(fontSize: 18.0),
                        ),
                        Container(
                          width: 100.0,
                          height: 40.0,
                          color: Colors.blue, // Cor de fundo do valor
                          child: Center(
                            child: Text(
                              "654",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
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
          ],
        ),
      ),
    );
  }
}
