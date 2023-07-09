import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basic/reservaSalas/application/reservaRequest.dart';
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
  }
@override
Widget build(BuildContext context) {
  final size = MediaQuery.of(context).size;
  final fem = size.width / 1440;

  return Scaffold(
    appBar: MyAppBar(),
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
                    child: Text(
                      'Salas Disponíveis',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black, fontSize: 60),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: 800,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: salasDisponiveis.length,
                      itemBuilder: (BuildContext context, int index) {
                        SalasBox salasBox = salasDisponiveis[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
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