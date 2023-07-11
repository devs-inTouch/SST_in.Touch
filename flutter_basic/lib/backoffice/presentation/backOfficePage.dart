import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basic/backoffice/anomalies/presentation/anomaliasVerifyPage.dart';
import 'package:flutter_basic/backoffice/presentation/moderacaoFeedsPage.dart';
import 'package:flutter_basic/backoffice/presentation/pedidosReservaSalaPage.dart';
import 'package:flutter_basic/backoffice/presentation/rolesUserPage.dart';
import 'package:flutter_basic/backoffice/presentation/statsAcessoPage.dart';

import '../../constants.dart';
import '../../myAppBar.dart';
import '../activateUser/presentation/ativacaoContasPage.dart';

class BackOffice extends StatefulWidget {
  const BackOffice({super.key});

  @override
  State<BackOffice> createState() => BackOfficePage();
}

class BackOfficePage extends State<BackOffice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      backgroundColor: myBackground,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.all(15),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.admin_panel_settings),
                    SizedBox(width: 10),
                    Text(
                      'BACK-OFFICE DE GESTÃO',
                      style: textStyleBar,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Container(
                  width: 600,
                  height: 700,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 70,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ModeracaoFeedsPage()),
                              );
                            },
                            style: styleBackOfficeButtons,
                            child: Text('Moderação de Feeds'),
                          ),
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          height: 70,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RolesUserPage()),
                              );
                            },
                            style: styleBackOfficeButtons,
                            child: Text('Roles de cada Utilizador'),
                          ),
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          height: 70,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => StatsAcessoPage()),
                              );
                            },
                            style: styleBackOfficeButtons,
                            child: Text('Estatística e controlo de acessos'),
                          ),
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          height: 70,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AtivacaoContasPage()),
                              );
                            },
                            style: styleBackOfficeButtons,
                            child: Text('Ativação de Contas'),
                          ),
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          height: 70,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AnomaliasVerifyPage()),
                              );
                            },
                            style: styleBackOfficeButtons,
                            child: Text('Verificação das anomalias pendentes'),
                          ),
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          height: 70,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PedidoReservaSalaPage()),
                              );
                            },
                            style: styleBackOfficeButtons,
                            child: Text('Pedidos e reservas de sala'),
                          ),
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
    );
  }
}
