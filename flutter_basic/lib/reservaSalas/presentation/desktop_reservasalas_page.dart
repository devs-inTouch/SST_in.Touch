import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basic/reservaSalas/presentation/salasBox.dart';
import 'package:flutter_basic/reservaSalas/presentation/salasDisponiveisPage.dart';
import 'package:intl/intl.dart';

import '../../constants.dart';
import '../../myAppBar.dart';
import '../application/reservaRequest.dart';

class ReservaSalasPage extends StatefulWidget {
  ReservaSalasPage({Key? key}) : super(key: key);

  @override
  _ReservaSalasPageState createState() => _ReservaSalasPageState();
}

class _ReservaSalasPageState extends State<ReservaSalasPage> {
  TextEditingController department = TextEditingController();
  TextEditingController room = TextEditingController();
  TextEditingController numberStudents = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController hour = TextEditingController();

  //late final  dateFormat = DateFormat('dd/MM/yyyy');



  List salasDisponiveisList = [];
  bool isChecking = false;

  void initState() {
    super.initState();
//    date = dateFormat.format(DateTime.now());
    //hour = horasDisponiveis[0];
  }

  void checkRooms({
  required String date,
  required String hour,
  }){
    print("hora e data"+date+hour);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>SalasDisponiveisPage(date: date,hour: hour)        ,
      ),
    );
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
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                        child: TextField(
                                          controller: date,
                                          decoration: const InputDecoration(
                                            fillColor: Colors.white,
                                            filled: true,
                                            labelText: 'DATA',
                                          ),
                                        ),

                                    ),
                                    SizedBox(width: 20),
                                    Expanded(
                                      flex: 2,
                                      child: TextField(
                                        controller: hour,
                                        decoration: const InputDecoration(
                                          fillColor: Colors.white,
                                          filled: true,
                                          labelText: 'HORA',
                                        ),
                                      ),

                                    ),
                                  ],
                                ),
                                SizedBox(height: 40),
                                Align(
                                  alignment: Alignment.center,
                                  child: ElevatedButton(
                                    onPressed: isChecking
                                        ? null
                                        : () => checkRooms(date: date.text, hour: hour.text),
                                    style: ElevatedButton.styleFrom(
                                      fixedSize: const Size(150, 50),
                                      backgroundColor: Colors.blue[800],
                                    ),
                                    child: const Text(
                                      'CRIAR',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),

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


/**
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
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Padding(
                                          padding: EdgeInsets.zero,
                                          child: Text(
                                            'DATA',
                                            style: textStyleReservaSalas,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    Expanded(
                                      flex: 2,
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          final DateTime? pickedDate =
                                              await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(2022),
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
                                    SizedBox(width: 20),
                                    Expanded(
                                      flex: 1,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Padding(
                                          padding: EdgeInsets.zero,
                                          child: Text(
                                            'HORA',
                                            style: textStyleReservaSalas,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    Expanded(
                                      flex: 2,
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
                                        dropdownColor: Colors.white,
                                        style: TextStyle(color: Colors.black),
                                        iconEnabledColor: Colors.black,
                                        underline: Container(
                                          height: 2,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 40),
                                Align(
                                  alignment: Alignment.center,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SalasDisponiveisPage(date: date, hour: hour),
                                        ),
                                      );
                                    },

                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.grey[300]!),
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
                          SizedBox(height: 20),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: TextButton(
                              onPressed: () {

                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.blueAccent[200]!),
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
    );
  }
  **/
}
