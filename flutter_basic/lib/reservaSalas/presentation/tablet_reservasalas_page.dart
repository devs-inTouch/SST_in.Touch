import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basic/reservaSalas/presentation/salasBox.dart';
import 'package:intl/intl.dart';

import '../../bottomAppBarMobile.dart';
import '../../constants.dart';
import '../../myAppBar.dart';
import '../application/reservaRequest.dart';

  class ReservaSalasPageMobile extends StatefulWidget {
    ReservaSalasPageMobile({Key? key}) : super(key: key);

  @override
  _ReservaSalasPageState createState() => _ReservaSalasPageState();
  }

  class _ReservaSalasPageState extends State<ReservaSalasPageMobile> {
  TextEditingController department = TextEditingController();
  TextEditingController room = TextEditingController();
  TextEditingController numberStudents = TextEditingController();
  TextEditingController data = TextEditingController();
  TextEditingController hora = TextEditingController();
  late String hour= '';
  late String date = '';
  late final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
  List<String> horasDisponiveis = [
    '08:00', '09:00', '10:00', '11:00', '12:00', '13:00', '14:00', '15:00',
    '16:00', '17:00', '18:00', '19:00', '20:00'
  ];
  void initState() {
    super.initState();
    date = dateFormat.format(DateTime.now());
    hour = horasDisponiveis[0];
  }
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: MyAppBar(),
      backgroundColor: myBackground,
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'RESERVAR SALA',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: FractionallySizedBox(
                    widthFactor: screenWidth < 700 ? 1.0 : 0.8,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.blueAccent[200],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.zero,
                                    child: Text(
                                      'DATA',
                                      style: textStyleReservaSalas,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      final DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2021),
                                        lastDate: DateTime(2024),
                                      );
                                      if (pickedDate != null) {
                                        setState(() {
                                          date =
                                              dateFormat.format(pickedDate);
                                        });
                                      }
                                    },
                                    child: Text(
                                      date != null
                                          ? date!
                                          : 'Selecione uma data',
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.zero,
                                    child: Text(
                                      'HORA',
                                      style: textStyleReservaSalas,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: DropdownButton<String>(
                                    value: hour,
                                    hint: Text('Selecione uma hora'),
                                    items: horasDisponiveis.map((hora) {
                                      return DropdownMenuItem<String>(
                                        value: hora,
                                        child: Text(hora),
                                      );
                                    }).toList(),
                                    onChanged: (String? selectedHour) {
                                      setState(() {
                                        hour = selectedHour!;
                                      });
                                    },
                                    // Set dropdown decoration
                                    dropdownColor: Colors.white,
                                    style: TextStyle(color: Colors.black),
                                    iconEnabledColor: Colors.black,
                                    underline: Container(
                                      height: 2,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                /**
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'DEPARTAMENTO',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: TextField(
                                    controller: department,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'SALA',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: TextField(
                                    controller: room,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                                 **/
                                SizedBox(height: 20),
                                Align(
                                  alignment: Alignment.center,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      List<SalasBox> roomsList = await ReservaAuth.getRoomsList(date, hour);
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Lista de Salas'),
                                            content: Container(
                                              width: double.maxFinite,
                                              child: ListView.builder(
                                                itemCount: roomsList.length,
                                                itemBuilder: (BuildContext context, int index) {
                                                  return SalasBox(
                                                    name: roomsList[index].name,
                                                    department: roomsList[index].department,
                                                    space: roomsList[index].space,
                                                    date: roomsList[index].date,
                                                    hour: roomsList[index].hour,
                                                  );
                                                },
                                              ),

                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text('Fechar'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.grey[300]!),
                                    ),
                                    child: Text(
                                      'VERIFICAR DISPONIBILIDADE',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),
                          /**
                          SizedBox(height: 20),
                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsetsDirectional.zero,
                              child: Text(
                                'NÚMERO DE ALUNOS',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: TextField(
                              controller: numberStudents,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          **/

                          SizedBox(height: 20),
                          Align(
                            alignment: Alignment.center,
                            child: TextButton(
                              onPressed: () {
                                // Add your desired action when the button is pressed
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent[200]!),
                              ),
                              child: Text(
                                'CONFIRMAR RESERVA',
                                style: textStyleReservaSalasButton,
                              ),
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
      ),
      bottomNavigationBar: MyBottomAppBar(),

    );
  }
}
