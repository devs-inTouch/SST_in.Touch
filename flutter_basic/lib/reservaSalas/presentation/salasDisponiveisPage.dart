import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basic/myAppBarMobile.dart';
import 'package:flutter_basic/reservaSalas/application/reservaRequest.dart';
import 'package:flutter_basic/reservaSalas/presentation/responsive_reservasalas.dart';
import 'package:flutter_basic/reservaSalas/presentation/salasBox.dart';

import '../../constants.dart';
import '../../myAppBar.dart';

class SalasDisponiveisPage extends StatefulWidget {
  final String date;
  final String hour;

  const SalasDisponiveisPage({Key? key, required this.date, required this.hour})
      : super(key: key);

  @override
  SalasDisponiveisState createState() => SalasDisponiveisState();
}

class SalasDisponiveisState extends State<SalasDisponiveisPage> {
  List salasDisponiveis = [];

  @override
  void initState() {
    super.initState();
    fetchSalasLivres();
  }

  void fetchSalasLivres() async {
    final response = await ReservaAuth.getRoomsList(widget.date, widget.hour);
    setState(() {
      salasDisponiveis = response;
    });
    print("SalasLivres fetched");
    print(salasDisponiveis);

    if (salasDisponiveis.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Sem salas livres"),
            content: Text("Nessa hora e data, não há salas disponíveis!"),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ResponsiveReservaSalas()),
                  );
                },
              ),
            ],
          );
        },
      );
    }
  }@override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fem = size.width / 1440;

    return Scaffold(
      backgroundColor: myBackground,
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "SALAS DISPONÍVEIS",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 26,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ResponsiveReservaSalas()),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      child: Container(
                        width: 800,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: salasDisponiveis.length,
                          itemBuilder: (BuildContext context, int index) {
                            SalasBox salasBox = salasDisponiveis[index];
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(10.0,20.0,10.0,20.0),
                              child: SalasBox(
                                name: salasBox.name,
                                department: salasBox.department,
                                space: salasBox.space,
                                date: salasBox.date,
                                hour: salasBox.hour,
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
          ),
        ],
      ),
    );
  }

}